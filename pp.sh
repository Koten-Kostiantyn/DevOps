#!/bin/bash

ssh -o "StrictHostKeyChecking no" -i oregon.pem ec2-user@$1 << EOF
sudo su
sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config 
sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config 

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

echo -e "1" | (passwd --stdin $USER)
service sshd restart

EOF

ssh -o "StrictHostKeyChecking no" -i oregon.pem ec2-user@$1 << HERE
sudo su
service puppetmaster start
HERE

# sed -i 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config
# sed -i 's/PasswordAuthentication/#PasswordAuthentication/g' /etc/ssh/sshd_config
