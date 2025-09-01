#!/bin/bash

# Install Java
set -euxo pipefail
dnf -y update
dnf -y install java-21-amazon-corretto
java -version >> /var/log/java_install.log 2>&1

# Install Docker
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user

# Install and configure CLoudWatch Agent
yum install -y amazon-cloudwatch-agent

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
    -a fetch-config \
    -m ec2 \
    -c ssm:${ssm_param_name} -s