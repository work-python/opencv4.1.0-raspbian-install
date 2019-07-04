#!/bin/bash
myPath="/home/" 
if [ ! -x "$myPath"]; then 
echo "只读文件系统解锁"
sudo mount /dev/mmcblk0p2 -o rw,remount
fi 
wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/SURF_test.tar.gz && tar -zxvf SURF_test.tar.gz && cd SURF_test
cmake .
make
./surf_test c1.jpg c2.jpg
