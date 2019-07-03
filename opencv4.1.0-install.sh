#!/bin/bash
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


cd /home/ && git clone https://github.com/lihuate/opencv4.1.0-raspbian-install.git
rm -rf /home/opencv4.1.0 && cd /home/
cp -R /home/opencv4.1.0-raspbian-install/opencv4.1.0 /home/opencv4.1.0 && rm -rf opencv4.1.0-raspbian-install/
############################
if  [ -f  "/etc/ld.so.conf.d/opencv.conf" ];then
  echo  "/etc/ld.so.conf.d/opencv.conf文件存在"
grep "/home/opencv/opencv4.1.0/lib" /etc/ld.so.conf.d/opencv.conf >/dev/null
if [ $? -eq 0 ]; then
    echo "/home/opencv/opencv4.1.0/lib存在跳过!"
else
    echo "/home/opencv/opencv4.1.0/lib不存在写入!"
    echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
fi
else
  echo  "/etc/ld.so.conf.d/opencv.conf文件不存在开使创建"
  echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
fi
ldconfig
###############################
if  [ -f  "~/.bashrc" ];then
  echo  ".bashrc文件存在"
grep 'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH' ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
    echo "存在跳过!"
else
    echo "ib/pkgconfig不存在写入!"
    echo  'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH'   >>  ~/.bashrc
fi
grep 'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH' ~/.bashrc >/dev/null
if [ $? -eq 0 ]; then
    echo "opencv4.1.0/lib存在跳过!"
else
    echo "opencv4.1.0/lib不存在写入!"
    echo  'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH'   >>  ~/.bashrc
fi
else
  echo  "bashrc文件不存在开使创建开始写入"
 echo  'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH'   >>  ~/.bashrc
 echo  'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH'   >>  ~/.bashrc
fi

source ~/.bashrc
echo "安装完成"
echo opencv版本 `pkg-config --modversion opencv4`
rm -rf opencv4.1.0-install.sh

