#!/bin/bash

#
# copy this into /etc/profile.d/instance-name-tag.sh
#
# you will need: 
# - curl, jq, and aws cli installed
# - an IAM role that gives the EC2 instance access to describe tags
#

JQ=$(which jq)
if [ ! -x "$JQ" ]; then
    #echo "jq is not installed. Install it and configure aws to display instance id and name."
    exit 1
fi

## get instance info
export AWS_INSTANCE_ID=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|jq .instanceId|tr -d '"')

## use region the instance is in as default region
export AWS_DEFAULT_REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document|jq .region|tr -d '"')

## make sure aws stuff is in the path
#PATH="/opt/aws/bin:$PATH"

TEST=$(aws sts get-caller-identity 2>/dev/null)
#echo "TEST = [$TEST]"
if [ "$TEST" != "" ]; then 

    ## grab the Name tag for this instance
    export NAMETAG=$(aws ec2 describe-tags --filters Name=resource-id,Values=$AWS_INSTANCE_ID Name=key,Values=Name|jq ".Tags[0].Value"|tr -d '"')
    #export PS1="\\t [\\u@${NAMETAG} \\W]\\\$ "
    #export $NAMETAG
    #echo $NAMETAG

else

    #export NAMETAG="$AWS_INSTANCE_ID"
    export NAMETAG=""
    #echo $NAMETAG
fi
