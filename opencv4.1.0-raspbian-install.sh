#!/bin/sh
myPath="/home/" 
if [ ! -x "$myPath"]; then 
echo "只读文件系统解锁"
sudo mount /dev/mmcblk0p2 -o rw,remount
fi 
apt-get install -y wget
apt-get install -y build-essential
apt-get install -y git
apt-get install -y libgtk2.0-dev
apt-get install -y pkg-config
apt-get install -y libavcodec-dev
apt-get install -y libavformat-dev
apt-get install -y libswscale-dev
apt-get install -y python-dev
apt-get install -y python-numpy
apt-get install -y libtbb2
apt-get install -y libtbb-dev
apt-get install -y libjpeg-dev
apt-get install -y libpng-dev
apt-get install -y libtiff-dev
apt-get install -y libjasper-dev
apt-get install -y libdc1394-22-dev
apt-get install -y c++
apt-get install -y g++
apt-get install -y gcc
apt-get install -y autoconf
apt-get install -y ncurses-devel
apt-get install -y automake 


# Install cpp headers for libcurl
 apt-get install libcurl4-gnutls-dev

# Download and build a cmake version with SSL support
# We use the system's libcurl to avoid later problems
mkdir /home/opencv4.1.0
mkdir /home/opencv
mdkir -p ~/tmp/cmake
cd !$


# wget https://cmake.org/files/v3.10/cmake-3.10.2.tar.gz
# tar -xzf cmake-3.10.2.tar.gz
# cd cmake-3.10.2/
# #wget --no-check-certificate https://cmake.org/files/v3.9/cmake-3.9.0.tar.gz
# #tar -zxvf cmake-3.9.0.tar.gz
# #cd cmake-3.9.0
# #./bootstrap --parallel=$(nproc) --system-curl
# #make -j $(nproc)
# ./bootstrap --system-curl
# make && make install
# # Uninstall cmake
# sudo apt remove cmake

# # Install new version from sources
# # (we should build a package instead)
# sudo make install


cmake -version
if [ $? -ne 0 ]; then
    echo "失败，"
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
    echo "请安装支持c++11的cmake版本，"
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





cd /home/opencv
wget -o opencv4.1.0.zip https://github.com/opencv/opencv/archive/4.1.0.zip
unzip opencv4.1.0.zip
mkdir /home/opencv/opencv4.1.0/build
wget -o opencv_contrib-4.1.0.tar.gz https://github.com/opencv/opencv_contrib/archive/4.1.0.tar.gz
tar -zxf opencv_contrib-4.1.0.tar.gz
cd /home/opencv/opencv4.1.0/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/opencv4.1.0/ -DOPENCV_EXTRA_MODULES_PATH=/home/opencv/opencv_contrib-4.1.0/modules/ -DWITH_CUDA=ON  -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_opencv_xfeatures2d=ON OPENCV_ENABLE_NONFREE=NO -DWITH_TBB = ON -DBUILD_TBB = ON ..
make -j10
make install


echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
ldconfig


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


source ~/.bashrc

pkg-config --modversion opencv4
if [ $? -ne 0 ]; then
    echo "失败，自我删除"
    rm -rf /home/opencv
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

