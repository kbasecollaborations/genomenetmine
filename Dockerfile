FROM knetminer/knetminer:4.0.1
EXPOSE 5000
RUN pip install requests
WORKDIR /root
ENV knet_build_dir=/root/knetminer-build
RUN mkdir -p /kb/module
RUN chmod a+rw /kb/module
copy . /kb/module

#WORKDIR /opt/apache-tomcat-9.0.29/
#RUN rm -rf webapps
#RUN python /kb/module/scripts/download.py https://app.box.com/shared/static/c85l3wvzm68tg3d6qvmxaq4u5jaw4vuj.tgz webapps.tgz \
#    && tar xvzf webapps.tgz

WORKDIR /root/knetminer-dataset
#poplar
#RUN rm -rf data \
#    && python /kb/module/scripts/download.py https://app.box.com/shared/static/c5f8x3fbrxky1fc7h8gtnm6q4zblkiqj.tgz  files.tgz \
#    && tar xvzf files.tgz \
#    && mv files/poplar_data/* . \
#    && rm -rf files

#potato
RUN rm -rf data \
    && python /kb/module/scripts/download.py https://app.box.com/shared/static/wo9gs9kysdye6znvcw2tsu739aml3iap.tgz files.tgz \
    && tar xvzf files.tgz \
    && mv files/* . \
    && rm -rf files

RUN mkdir -p /kb/module/work
RUN chmod a+rwx /kb/module/work

ENTRYPOINT ["sh", "/kb/module/scripts/entrypoint.sh"]

