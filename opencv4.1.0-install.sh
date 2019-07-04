#!/bin/bash
myPath="/home/" 
if [ ! -x "$myPath"]; then 
echo "只读文件系统解锁"
sudo mount /dev/mmcblk0p2 -o rw,remount
fi 
apt-get install -y wget && apt-get install -y build-essential
apt-get install -y git && apt-get install -y libgtk2.0-dev
apt-get install -y pkg-config && apt-get install -y libavcodec-dev
apt-get install -y libavformat-dev && apt-get install -y libswscale-dev
apt-get install -y python-dev && apt-get install -y python-numpy
apt-get install -y libtbb2 && apt-get install -y libtbb-dev
apt-get install -y libjpeg-dev && apt-get install -y libpng-dev
apt-get install -y libtiff-dev && apt-get install -y libjasper-dev
apt-get install -y libdc1394-22-dev
apt-get install -y c++ && apt-get install -y g++ && apt-get install -y gcc && apt-get install -y autoconf
apt-get install -y ncurses-devel && apt-get install -y automake 
#######
if  [ -d "/home/opencv4.1.0/" ];then
  echo  "文件夹存在"
  rm -rf /home/opencv4.1.0 && cd /home/
  cd /home/ && git clone https://github.com/lihuate/opencv4.1.0-raspbian-install.git
  cp -R /home/opencv4.1.0-raspbian-install/opencv4.1.0 /home/opencv4.1.0 && rm -rf opencv4.1.0-raspbian-install/
else
  echo  "文件夹不存在"
  cd /home/ && git clone https://github.com/lihuate/opencv4.1.0-raspbian-install.git
  cp -R /home/opencv4.1.0-raspbian-install/opencv4.1.0 /home/opencv4.1.0 && rm -rf opencv4.1.0-raspbian-install/
fi
#######
if  [ -f  "/etc/ld.so.conf.d/opencv.conf" ];then
  echo  "/etc/ld.so.conf.d/opencv.conf文件存在"
grep "/home/opencv/opencv4.1.0/lib" /etc/ld.so.conf.d/opencv.conf >/dev/null
if [ $? -eq 0 ]; then
    echo '环境变量：/home/opencv/opencv4.1.0/lib存在跳过!'
else
    echo '环境变量：/home/opencv/opencv4.1.0/lib不存在写入!'
    echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
fi
else
  echo  '环境变量：/etc/ld.so.conf.d/opencv.conf文件不存在开使创建'
  echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
fi
ldconfig
##########
#if  [ -f  '~/.bashrc' ];then
#  echo  ".bashrc文件存在"
#  else
#  echo  "bashrc文件不存在开使创建开始写入"
#  echo  'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH'   >>  ~/.bashrc
#  echo  'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH'   >>  ~/.bashrc
#fi
grep 'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH' ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
   echo '环境变量：opencv4.1.0/lib存在!'
else
    echo '环境变量：lib/pkgconfig不存在写入!'
    echo  'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH'   >>  ~/.bashrc
fi
grep 'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH' ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
    echo '环境变量：opencv4.1.0/lib存在跳过!'
else
    echo '环境变量：opencv4.1.0/lib不存在写入!'
    echo  'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH'   >>  ~/.bashrc
fi


source ~/.bashrc




cmake -version
if [ $? -ne 0 ]; then
    echo "失败，"
    apt-get install libcurl4-gnutls-dev
    echo "开始安装cmake3.10.2"
    wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/cmake-3.10.2.tar.gz
    tar -xzf cmake-3.10.2.tar.gz
    cd cmake-3.10.2/
    ./bootstrap --system-curl
    make -j2 && make install
    sudo apt remove cmake
    sudo make install
else
    echo "成功系统存在cmake"
    echo "cmake版本及库信息："
    echo "请确认当前版本支持c++11，"
    echo opencv版本 `cmake -version`
fi
cmake -version
if [ $? -ne 0 ]; then
    echo "失败，请手动安装cmake1.10.X以上版本"
 else  
fi 
rm -rf cmake-3.10.2.tar.gz
cd ..
rm -rf cmake-3.10.2/
pkg-config --modversion opencv4
if [ $? -ne 0 ]; then
    echo "失败，自我删除"
    rm -rf /home/opencv4.1.0
    rm -rf $0
else
    echo "成功"
    echo "opencv版本及库信息："
    echo opencv版本 `pkg-config --modversion opencv4`
    # 4.0.1
    echo opencv依赖  `pkg-config --libs opencv4`
    echo cflags `pkg-config --cflags opencv4`
fi
rm -rf $0

