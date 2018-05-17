#!/bin/bash

echo '你正在执行更新脚本，请三思，做好背锅准备才确定。若退出请Ctrl+C'
read NONSENE

echo 'input package name:'
read PACKAGE

if [ -z "$PACKAGE"  ]
then
    echo '输入包名啦嗨佬'
     exit
else
   echo ''
fi

echo 'input profile'
read PROFILE

if [ -z "$PROFILE" ]
then
    PROFILE='dev-zch'
    echo $PROFILE
fi

kill -9 `cat tpid`

VM_OPTIONS='-Xms64M -Xmx256M -XX:MetaspaceSize=128M -XX:MaxMetaspaceSize=256M'
SPRING_PROFILE='--spring.profiles.active='$PROFILE
ENCODING='-Dfile.encoding=UTF-8'

nohup java -jar $PACKAGE $VM_OPTIONS $SPRING_PROFILE $ENCODING 2>&1 &

echo $! > tpid

tail -f logs/info.log
