# скрипт который автоматом устанавливает паппет и делает пользователя рутом и ставил пароль 1 и разрешал подключения с папролем
# это все работает на AMI linux от Amazon
# этому скрипту нужны два файла, если что, это конфиг паппета и сайт.рр
#!/bin/bash
	#######################################################
	###	CONFIG SSH FOR ROOT/1(password) LOGIN
	#######################################################
ssh -o "StrictHostKeyChecking no" -i oregon-nbc.pem ec2-user@$1 << EOF

sudo su
sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config 
sed -i '/PasswordAuthentication/d' /etc/ssh/sshd_config 

echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
echo "PasswordAuthentication yes" >> /etc/ssh/sshd_config

echo -e "1" | (passwd --stdin $USER)
service sshd restart
	#######################################################
	###	INSTALL&CONFIGURE PUPPET
	#######################################################
yum -y install puppet-server
chkconfig puppetmaster on
EOF

/usr/local/bin/sshpass -p '1' scp site.pp root@$1:/etc/puppet/manifests
/usr/local/bin/sshpass -p '1' scp puppet.conf root@$1:/etc/puppet 

/usr/local/bin/sshpass -p '1' ssh -o "StrictHostKeyChecking no" root@$1 << HERE
service puppetmaster start
puppet agent -t
HERE
