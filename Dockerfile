# Openshift-like server to test your python 2.7 applications
#
# build images:
#   docker build -q -t lrivallain/openshift .
#
# run a container:
#   docker run -v `pwd`:/data -p 8080:8080 lrivallain/openshift

# based on debian image
FROM google/debian:wheezy
MAINTAINER ludovic.rivallain@gmail.com

# upgrade packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get upgrade -qqy

# install python 2.6 and virtualenv
RUN apt-get install python2.6 python2.6-dev build-essential python-pip -qqy
RUN pip install virtualenv
RUN env --unset=DEBIAN_FRONTEND

# create a folder for openshift virtualenv for python 2.7
RUN mkdir -p /opt/openshift_run
RUN virtualenv /opt/openshift/python/virtenv -p python2.6 --no-site-packages
RUN . /opt/openshift/python/virtenv/bin/activate && pip install uwsgi

# add and chmod the run script for app
ADD uwsgi.run /opt/uwsgi.run
RUN chmod +x /opt/uwsgi.run

# minimals openshift env variables
ENV OPENSHIFT_PYTHON_VERSION 2.6
ENV OPENSHIFT_HOMEDIR /opt/openshift/

# default command
CMD [ "/bin/bash", "/opt/uwsgi.run" ]

# expose app on 8080
EXPOSE 8080