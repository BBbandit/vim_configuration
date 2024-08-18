#!/bin/sh

XSHELL="/mnt/c/Program Files (x86)/NetSarang/Xshell 7/Xshell.exe"
INET=$(ifconfig eth0 | grep "inet " | awk '{print $2}')
PASSWD="123456"

#保存当前路径
pwd > ~/last_pwd.tmp

#开启ssh服务
echo $PASSWD | sudo -S /etc/init.d/ssh start
# sudo -S /etc/init.d/ssh start << EOF
# echo $PASSWD
# /etc/init.d/ssh start

# echo ssh://$USERNAME:123456@$INET
# echo ssh://$USERNAME:$PASSWD@$(ifconfig eth0 | grep "inet " | awk '{print $2}') 

#打开xshell
$XSHELL -url ssh://$USERNAME:$PASSWD@$INET 


