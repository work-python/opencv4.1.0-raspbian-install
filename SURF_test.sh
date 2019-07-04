#!/bin/bash
myPath="/home/" 
if [ ! -x "$myPath"]; then 
echo "只读文件系统解锁"
sudo mount /dev/mmcblk0p2 -o rw,remount
fi 

echo `cmake -version` > e.txt
path=`cut -d ' ' -f 3 e.txt`
rm -rf e.txt
if [[ $path =~ "3.9.0.1" ]] ; then
   echo '3.9.0存在!'
echo '程序继续执行!'
else
    echo '找不到3.9.0'
    echo 当前cmake版本号是 $path
    sed -i "s/3.10.2/$path/g" CMakeLists.txt
    echo 替换成功 ,继续运行
fi


wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/SURF_test.tar.gz && tar -zxvf SURF_test.tar.gz && cd SURF_test
cmake .
make
./surf_test c1.jpg c2.jpg
