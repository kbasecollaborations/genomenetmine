FROM knetminer/knetminer:4.0.1
EXPOSE 5000
RUN pip install requests
WORKDIR /root
ENV knet_build_dir=/root/knetminer-build
RUN mkdir -p /kb/module/work
RUN chmod a+rw /kb/module/work

WORKDIR $knet_build_dir
COPY . knetminer
ENTRYPOINT ["sh", "/root/knetminer-build/knetminer/scripts/entrypoint.sh"]
#CMD ["aratiny"] # The id of the default dataset

