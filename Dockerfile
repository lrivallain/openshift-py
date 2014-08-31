# Openshift-like server to test your python 2.7 applications
#
# build images:
#   docker build -q -t lrivallain/openshift .
#
# run a container:
#   docker run -v /data/openshift:/data -p 8080:8080 lrivallain/openshift

# based on debian image
FROM google/debian:wheezy
MAINTAINER ludovic.rivallain@gmail.com

# upgrade packages
RUN apt-get update
RUN apt-get upgrade -qqy

# install usgi
RUN apt-get install build-essential python-dev python-pip  -qqy
RUN pip install uwsgi
RUN pip install virtualenv

# create a folder for openshift virtualenv for python 2.7
RUN mkdir -p /opt/openshift_run
RUN virtualenv /opt/openshift_run/venv -p python2.7 --no-site-packages

# add and chmod the run script for app
ADD uwsgi.run /opt/uwsgi.run
RUN chmod +x /opt/uwsgi.run

# default command
CMD [ "/bin/bash", "/opt/uwsgi.run" ]

# expose app on 8080
EXPOSE 8080