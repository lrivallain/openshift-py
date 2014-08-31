Run an OpenShift based + Py2.6 + Flask in a Docker container
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
    git remote add upstream -m master https://github.com/lrivallain/openshift.git
    git pull -s recursive -X theirs upstream master
    

Then build container image

    docker build -q -t lrivallain/openshift-py2.7 .

or get image from docker public repository

    docker pull lrivallain/openshift-py2.7


And run a container based on this image

    docker run -v `pwd`:/data -p 8080:8080 lrivallain/openshift-py2.7

That's it, you can now checkout your application at:

    http://127.0.0.1:8080


Running on Openshift
--------------------

Push change to openshift

    git push

That's it, you can now checkout your application at:

    http://myflaskapp-$yournamespace.rhcloud.com

Python 2.6
----------

To run a docker container for Openshift + Python 2.6 + Flask:

build container image

    docker build -q -t lrivallain/openshift-py2.6 - < Dockerfile2.6

or get image from docker public repository

    docker pull lrivallain/openshift-py2.6
