# Openshift-like server to test your python 2.6 applications
#
# build images:
#   docker build -q -t lrivallain/openshift-py2.6 .
#
# run a container:
#   docker run -v `pwd`:/data -p 8080:8080 lrivallain/openshift-py2.6

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
RUN unset DEBIAN_FRONTEND

# create a folder for openshift virtualenv for python 2.7
RUN mkdir -p /opt/openshift_run
RUN virtualenv /opt/openshift/python/virtenv -p python2.6 --no-site-packages
RUN . /opt/openshift/python/virtenv/bin/activate && pip install uwsgi

# add and chmod the run script for app
ADD uwsgi.run /opt/uwsgi.run
RUN chmod +x /opt/uwsgi.run

# create folders
RUN mkdir /opt/openshift_run/logs/
RUN mkdir /opt/openshift_run/data/

# minimals openshift env variables
ENV OPENSHIFT_PYTHON_VERSION 2.6
ENV OPENSHIFT_PYTHON_DIR     /opt/openshift/python/
ENV OPENSHIFT_HOMEDIR        /opt/openshift/
ENV HOME                     /opt/openshift/
ENV HISTFILE                 /root/.bash_history
ENV TMP                      /tmp/
ENV OPENSHIFT_DATA_DIR       /opt/openshift_run/data/
ENV OPENSHIFT_PYTHON_LOG_DIR /opt/openshift_run/logs/
ENV OPENSHIFT_REPO_DIR       /data/
ENV OPENSHIFT_TMP_DIR        /tmp/

# default command
CMD [ "/bin/bash", "/opt/uwsgi.run" ]

# expose app on 8080
EXPOSE 8080