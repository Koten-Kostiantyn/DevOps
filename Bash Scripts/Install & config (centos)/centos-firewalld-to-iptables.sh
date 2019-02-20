#!/bin/sh
sudo yum install iptables-services
sudo systemctl stop firewalld && sudo systemctl start iptables; sudo systemctl start ip6tables;
sudo firewall-cmd --state
sudo systemctl disable firewalld
sudo systemctl enable iptables
sudo systemctl enable ip6tables
echo "firewalld to iptables: done"
