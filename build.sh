#!/bin/bash

# build image
docker build --rm -q -t lrivallain/openshift .

# create a shared folder
boot2docker ssh "sudo [ -d /data/openshift ] || mkdir -p /data/openshift"
boot2docker ssh "sudo chown -R docker: /data/openshift"

# Copy files to shared folder
scp -q -i ~/.ssh/id_boot2docker -r ./ docker@boot2docker:/data/openshift

# Run Openshift container
docker run -v /data/openshift:/data -p 8080:8080 lrivallain/openshift