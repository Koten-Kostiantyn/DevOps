
#!/bin/sh
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -A INPUT -m limit --limit 2/s -s 0.0.0.0/0 -j ACCEPT
iptables -A FORWARD -m limit --limit 2/s -s 0.0.0.0/0 -j ACCEPT
/sbin/service iptables save
echo "iptables: done"
