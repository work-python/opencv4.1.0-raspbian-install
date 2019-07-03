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
cd /home/
git clone https://github.com/lihuate/opencv4.1.0-raspbian-install.git
cp -R /opencv4.1.0-raspbian-install/opencv4.1.0 /home/opencv4.1.0 && rm -rf opencv4.1.0-raspbian-install/
echo "/home/opencv/opencv4.1.0/lib" >/etc/ld.so.conf.d/opencv.conf
ldconfig
echo  'export PKG_CONFIG_PATH=/home/opencv4.1.0/lib/pkgconfig:$PKG_CONFIG_PATH'   >>  ~/.bashrc
echo  'export LD_LIBRARY_PATH=/home/opencv4.1.0/lib:$LD_LIBRARY_PATH'    >>  ~/.bashrc
source ~/.bashrc
