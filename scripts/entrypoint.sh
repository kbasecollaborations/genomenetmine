#!/bin/bash

# Docker container entry point script
# When you run docker run my-app xyz, then this script will get run

# Persistent server mode (aka "dynamic service"):
# This is run when there are no arguments
if [ $# -eq 0 ] ; then

  cd /root/knetminer-build/knetminer
  mydir="/root/knetminer-build/knetminer"
  set -x
  echo -e "\n\n\tInitial environment:"
  env
  echo $knet_dataset_id
  knet_dataset_dir=${2:-/root/knetminer-dataset}
  knet_tomcat_home=${3-$CATALINA_HOME}
  export MAVEN_ARGS=${MAVEN_ARGS:-'-Pdocker'}
  export JAVA_TOOL_OPTIONS=${JAVA_TOOL_OPTIONS:-'-XX:MaxRAMPercentage=90.0 -XX:+UseContainerSupport -XX:-UseCompressedOops'}
  knet_codebase_dir="/root/knetminer-build/knetminer"
  echo $knet_codebase_dir
  echo -e "\n\n\tBuilding the client app\n"

  # Finally, dataset-specific sources are placed in the config directory, so you're able to see the from the host
  client_src_dir="$knet_dataset_dir/client-src"
  client_html_dir="$client_src_dir/src/main/webapp/html"

  # Common client files
  cd "$knet_codebase_dir"
  rm -Rf common/aratiny/aratiny-client/target

  cp -Rf common/aratiny/aratiny-client/* "$client_src_dir"

  # Additions and overridings from the dataset instance-specific dir
  cp "$knet_dataset_dir/settings/client/"*.xml "$client_html_dir/data"
  for ext in jpg png gif svg tif
    do
	    # Ignore 'source file doesn't exist'
	    cp "$knet_dataset_dir/settings/client/"*.$ext "$client_html_dir/image" || :
    done

[ -e "$knet_dataset_dir/settings/client/release_notes.html" ] && \
  sed -e "/\${knetminer.releaseNotesHtml}/{r $knet_dataset_dir/settings/client/release_notes.html" -e 'd}' \
    "$client_html_dir/release.html" -i'' "$client_html_dir/release.html"
    # OK, all client files instantiated, now let's build the client from the build dir
    cd "$client_src_dir"
    mvn $MAVEN_ARGS --settings "$knet_dataset_dir/config/actual-maven-settings.xml" -DskipTests -DskipITs clean package
    # Let's copy to Tomcat
    cp target/knetminer-aratiny.war "$knet_tomcat_home/webapps/client.war"

  echo "Running in persistent server mode"
  knet_tomcat_home=${3-$CATALINA_HOME}
  echo -e "\n\n\tRunning the Jetty server\n"
  cd "$knet_tomcat_home/bin"
  cp "/kb/module/scripts/start.ini" /opt/jetty
  cp /kb/module/scripts/server_new.xml "$knet_tomcat_home/conf"
  du -a /opt/tomcat/webapps >/kb/module/tomcat.txt
  cp /opt/tomcat/webapps/*.war /opt/jetty/webapps/
  du -a /opt/jetty/webapps >/kb/module/jetty.txt
  cd /opt/jetty
  java -jar start.jar
#  ./catalina.sh run -config conf/server_new.xml 

echo -e "\n\n\tJetty Server Stopped, container script has finished\n"

# Run tests
elif [ "${1}" = "test" ] ; then
  echo "Running tests..."
  echo "...done running tests."

# One-off jobs
elif [ "${1}" = "async" ] ; then
  echo "Running a one-off job... nothing to do."

# Initialize?
elif [ "${1}" = "init" ] ; then
  echo "Initializing module... nothing to do."

# Bash shell in the container
elif [ "${1}" = "bash" ] ; then
  echo "Launching a bash shell in the docker container."
  bash

# Required file for registering the module on the KBase catalog
elif [ "${1}" = "report" ] ; then
  echo "Generating report..."
  cp /kb/module/compile_report.json /kb/module/work/compile_report.json

else
  echo "Unknown command. Valid commands are: test, async, init, bash, or report"
fi




