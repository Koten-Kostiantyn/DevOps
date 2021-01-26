#!/bin/bash

sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config 
sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config 
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config
chpasswd <<<"root:1"
service sshd restart

