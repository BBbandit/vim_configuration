#!/bin/sh

MOBAXTERM="/mnt/c/Users/DZ-2021-307/Desktop/MobaXterm_20.0_cn/MobaXterm_20.0汉化/MobaXterm1_CHS1.exe"
INET=$(ifconfig eth0 | grep "inet " | awk '{print $2}')
PASSWD="123456"

#保存当前路径
pwd > ~/last_pwd.tmp

#开启ssh服务
echo $PASSWD | sudo -S /etc/init.d/ssh start

#打开MobaXterm1_CHS1.exe
$MOBAXTERM -newtab "sshpass -p $PASSWD ssh $USERNAME@$INET"

