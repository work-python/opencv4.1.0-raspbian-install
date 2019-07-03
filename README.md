# 树莓派3b 解压版

树莓派3b的opencv4.1.0解压后直接用

支持c++

支持xfeatures2d

支持opencv_contrib

当时的编译命令是：
```
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/home/opencv4.1.0/ -DOPENCV_EXTRA_MODULES_PATH=/home/opencv/opencv_contrib-4.1.0/modules/ -DWITH_CUDA=ON  -DOPENCV_GENERATE_PKGCONFIG=ON -DBUILD_opencv_xfeatures2d=ON OPENCV_ENABLE_NONFREE=NO  ..
```

请在/home/目录执行:
```git clone https://github.com/lihuate/opencv4.1.0-raspbian-install.git```

确保目录结构是这样的：

```
/home/opencv4.1.0/

│   │   ├── 
│   │   │   ├── home
│   │   │   │   └── opencv4.1.0


```


# 一件编译安装版
###  opencv4.1.0-raspbian-install
opencv4.1.0树莓派一键编译安装脚本

wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/opencv4.1.0-raspbian-install.sh &&chmod 777 opencv4.1.0-raspbian-install.sh &&bash opencv4.1.0-raspbian-install.sh

如果安装时硬盘变成只读
sudo mount /dev/mmcblk0p2 -o rw,remount
