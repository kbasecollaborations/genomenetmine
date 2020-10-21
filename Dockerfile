FROM knetminer/knetminer
EXPOSE 8080

# See the documentation for details on what the dataset dir is
ENV knet_build_dir=/root/knetminer-build


# ---- Here we go
#

# If this is run in dev mode, we need 'docker build -f .' from the codebase root directory, since
# climbing up the host paths is forbidden
#
WORKDIR $knet_build_dir
COPY . knetminer
#WORKDIR knetminer/common/quickstart


ENTRYPOINT ["sh", "/root/knetminer-build/knetminer/entrypoint.sh"]
#ENTRYPOINT ["sh"]

#CMD ["aratiny"] # The id of the default dataset


