# 树莓派3b 解压版
一键安装脚本：
```
# 请在root环境下执行
# 请执行：
sudo apt-get install wget

wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/opencv4.1.0-install.sh && chmod 777 opencv4.1.0-install.sh && bash opencv4.1.0-install.sh
```
## 脚本详情
支持c++

支持xfeatures2d

支持opencv_contrib

当时的编译指令是：
```
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/opencv4.1.0/ -DOPENCV_EXTRA_MODULES_PATH=/home/opencv/opencv_contrib-4.1.0/modules/ -DWITH_CUDA=ON  -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_opencv_xfeatures2d=ON OPENCV_ENABLE_NONFREE=NO  ..
```

## 手动安装



请先执行如下命令配置环境：

```
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
```



请在/home/目录执行:
```
   git clone https://github.com/lihuate/opencv4.1.0-raspbian-install.git
   cp -R opencv4.1.0-raspbian-install/ opencv4.1.0 &&rm -rf opencv4.1.0-raspbian-install/
```

确保目录结构是这样的：

```
/home/opencv4.1.0/

 │   ├── 
 │   │   ├── home
 │   │   │   └── opencv4.1.0


```

配置环境变量：

```
echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
ldconfig

echo  'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH'   >>  ~/.bashrc
echo  'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH'    >>  ~/.bashrc
source ~/.bashrc

```

查看opencv版本及库信息：

```
pkg-config --modversion opencv4
# 4.0.1
pkg-config --libs opencv4
pkg-config --cflags opencv4
```


# 一件编译安装版
###  opencv4.1.0-raspbian-install
opencv4.1.0树莓派一键编译安装脚本

wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/opencv4.1.0-raspbian-install.sh &&chmod 777 opencv4.1.0-raspbian-install.sh &&bash opencv4.1.0-raspbian-install.sh

如果安装时硬盘变成只读
sudo mount /dev/mmcblk0p2 -o rw,remount
