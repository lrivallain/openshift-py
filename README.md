Run an OpenShift based + Py2.7 + Flask in a Docker container
============================================================

This git repository helps you create a simple container to run a Python2.7 + Flask application for openshift, in a docker container.


Running on Docker
-----------------
Install Docker: http://docker.io

Create an account at https://www.openshift.com

Create a python application

    rhc app create myflaskapp python-2.7

Add this upstream flask repo

    cd myflaskapp  
    git remote add upstream -m master https://github.com/lrivallain/openshift-py.git
    git pull -s recursive -X theirs upstream master
    

Then build container image

    docker build -q -t lrivallain/openshift-py2.7 .

or get the same image from docker public repository

    docker pull lrivallain/openshift-py2.7


And run a container based on this image

    docker run -v `pwd`:/data -p 8080:8080 -ti lrivallain/openshift-py2.7

That's it, you can now checkout your application at:

    http://127.0.0.1:8080


Running on Openshift
--------------------

Push change to openshift

    git push

That's it, you can now checkout your application at:

    http://myflaskapp-$yournamespace.rhcloud.com


Environment variables
---------------------
Following environment variables are set in containers and can be used in your applications:

    HISTFILE="/root/.bash_history"
    HOME="/opt/openshift/"
    OPENSHIFT_DATA_DIR="/opt/openshift_run/data/"
    OPENSHIFT_HOMEDIR="/opt/openshift/"
    OPENSHIFT_PYTHON_DIR="/opt/openshift/python/"
    OPENSHIFT_PYTHON_LOG_DIR="/opt/openshift_run/logs/"
    OPENSHIFT_PYTHON_VERSION="2.7"
    OPENSHIFT_REPO_DIR="/data/"
    OPENSHIFT_TMP_DIR="/tmp/"
    TMP="/tmp/"

For more informations about usage of environment variables, please refer to the openshift documention: https://access.redhat.com/documentation/en-US/OpenShift_Online/2.0/html/Cartridge_Specification_Guide/chap-Environment_Variables.html


Python 2.6
----------

To run a docker container for Openshift + Python 2.6 + Flask:

build container image from python 2.6 Dockerfile

    cd py-2.6
    docker build -q -t lrivallain/openshift-py2.6 .

or get the same image from docker public repository

    docker pull lrivallain/openshift-py2.6

And run a container based on this image

    docker run -v `pwd`:/data -p 8080:8080 -ti lrivallain/openshift-py2.6
