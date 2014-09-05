#!/bin/bash

# Usages:
#        ./tests.sh
#        ./tests.sh myapp
#        ./tests.sh myapp 9000
#        ./tests.sh myapp 9000 ~/.tmp/
#        ./tests.sh myapp 9000 ~/.tmp/ 35
#

# settings
[ -z $1 ] && APPNAME=python27 || APPNAME=$1
[ -z $2 ] && APPPORT=8080     || APPPORT=$2
[ -z $3 ] && APPROOT=/tmp     || APPROOT=$3
[ -z $4 ] && APPTIMEOUT=60    || APPTIMEOUT=$4

# get docker host IP
if [ -z "$DOCKER_HOST" ]; then
    DOCKER_IP=127.0.0.1
else
    DOCKER_IP=`echo $DOCKER_HOST | awk -F "[\:\/]+" '{print $2}'`
fi

# temp directory
cd $APPROOT

# create a temporary app
rhc app create $APPNAME python-2.7

# add upstream content
cd $APPNAME
git remote add upstream -m master https://github.com/lrivallain/openshift.git
git pull -s recursive -X theirs upstream master

# build the container image
docker build -q -t lrivallain/openshift-py2.7 .

# run a container from image
docker run -d --name $APPNAME -v `pwd`:/data -p $APPPORT:8080 -ti lrivallain/openshift-py2.7

# test the application
echo "Waiting $APPTIMEOUT seconds for container to start application..."
sleep $APPTIMEOUT
appcontent=`curl -s http://$DOCKER_IP:$APPPORT`
[ "$appcontent"='Hello World!' ] && echo 'Working !' || echo 'Not working :('

# clean container, app and folder
docker rm -f $APPNAME
rhc app delete $APPNAME --confirm
sudo rm -rf $APPROOT/$APPNAME # "sudo" because build is run as root in container :(
