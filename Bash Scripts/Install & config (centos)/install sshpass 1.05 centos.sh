#!/bin/bash

sudo su
wget http://sourceforge.net/projects/sshpass/files/sshpass/1.05/sshpass-1.05.tar.gz/download
mv download sshpass-1.05.tar.gz
tar zxvf sshpass-1.05.tar.gz
cd sshpass-1.05
yum -y groupinstall "Development Tools"
sudo ./configure
sudo make install
echo "ls /usr/local/bin/:" && echo `ls /usr/local/bin/`
