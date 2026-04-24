#!/bin/bash
set -e

# Update system
sudo yum update -y
sudo yum upgrade -y

# Install Java
sudo yum install java-21-amazon-corretto -y
java -version

#Do not run Nexus Repository from a user's home directory for production deployments; a common practice is to use the /opt directory.
mkdir /opt
cd /opt

#Download the nexus repository
wget https://download.sonatype.com/nexus/3/nexus-3.91.1-04-linux-x86_64.tar.gz
tar -zxvf nexus-3.91.1-04-linux-x86_64.tar.gz
cd nexus-3.91.1-04
cd /opt

#create & add user to the nexus file as root user does not have permission to execute the nexus repository
useradd nexus
chown -R nexus:nexus nexus-3.91.1-04 sonatype-work

# switch to nexus user and start nexus
su - nexus
cd /opt
cd nexus-3.91.1-04
cd bin
./nexus start

