#!/bin/bash
sudo /bin/bash
apt-get update -y
apt-get install fontconfig openjdk-17-jre -y
wget -O /usr/share/keyrings/jenkins-keyring.asc  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key /
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
apt-get update -y
apt-get install jenkins -y
ufw disable
sudo jenkins
sudo cat /root/.jenkins/secrets/initialAdminPassword
