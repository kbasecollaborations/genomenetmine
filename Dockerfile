FROM knetminer/knetminer
EXPOSE 8080

COPY . knetminer
#WORKDIR knetminer/common/quickstart

# Note that this issues 'mvn install' from your local copy of the knetminer codebase, WITHOUT clean.
# The idea is that it leverages Docker-base and adds up updates from your host copy.
# If you need to rebuild from clean code, just clean your host copy before building the Docker image.
# (TODO: document this)
#

#RUN touch /etc/crontab /etc/cron*/* \
#  && cp -r .aws ~/ \
#  && ./build-helper.sh '' "$TOMCAT_PASSWORD"

ENTRYPOINT ["sh"]

#CMD ["aratiny"] # The id of the default dataset


