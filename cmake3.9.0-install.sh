#!/bin/bash
myPath="/home/" 
if [ ! -x "$myPath"]; then 
echo "只读文件系统解锁"
sudo mount /dev/mmcblk0p2 -o rw,remount
fi 


cmake -version
if [ $? -ne 0 ]; then
    echo "失败，"
    apt-get install libcurl4-gnutls-dev
    rm -rf cmake-3.9.0.tar.gz
     rm -rf cmake-3.9.0/
    echo "开始安装cmake3.10.2"
    wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/cmake-3.9.0.tar.gz
    tar -xzf cmake-3.9.0.tar.gz
    cd cmake-3.9.0/
    ./bootstrap --system-curl
    make -j2 && make install
    sudo apt remove cmake
    sudo make install
else
    echo "成功系统存在cmake"
    echo "cmake版本及库信息："
    echo "请安装支持c++11的cmake版本，"
    echo opencv版本 `cmake -version`
fi
cmake -version
if [ $? -ne 0 ]; then
    echo "失败，请手动安装cmake1.10.X以上版本"
 else  
fi 
