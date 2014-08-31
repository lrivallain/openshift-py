APPNAME=python27
APPROOT=/tmp
APPPORT=8080
APPTIMEOUT=60
DOCKER_IP=`echo $DOCKER_HOST | awk -F "[\:\/]+" '{print $2}'`

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
docker run -d --name $APPNAME -v `pwd`:/data -p $APPROOT:8080 -ti lrivallain/openshift-py2.7

# test the application
echo "Waiting $APPTIMEOUT seconds for container to start application..."
sleep $APPTIMEOUT
appcontent=`curl http://$DOCKER_IP:$APPPORT`
[ appcontent -eq "Hello World!"] && echo "Working !" || echo "Not working :("

docker rm $APPNAME