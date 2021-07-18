#!/bin/bash
sudo yum update -y

mkdir /home/ec2-user/kits
mkdir /home/ec2-user/git

#Install Git
sudo yum install git -y

# Download the config file and start shell script from Git repo
# This will be under "telegraf" folder
cd /home/ec2-user/git
git clone https://github.com/banuady/telegraf.git

#Download Telegraf
cd /home/ec2-user/kits
wget https://dl.influxdata.com/telegraf/releases/telegraf-1.19.1_linux_amd64.tar.gz
tar xf telegraf-1.19.1_linux_amd64.tar.gz
mv telegraf-1.19.1/ telegraf

# Update the config file and copy the start shell script
mv /home/ec2-user/git/telegraf/telegraf.conf /home/ec2-user/kits/telegraf/etc/telegraf
mv /home/ec2-user/git/telegraf/start-telegraf.sh /home/ec2-user/kits/telegraf

# Start Telegraf
cd /home/ec2-user/kits/telegraf
sudo sh start-telegraf.sh

#Install Docker
sudo amazon-linux-extras install docker
sudo service docker start
sudo usermod -a -G docker ec2-user

# Start Docker container with the app
docker run -p 80:8080 banuady/zipwebapp