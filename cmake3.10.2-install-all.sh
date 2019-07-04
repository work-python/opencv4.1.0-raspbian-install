cmake -version
if [ $? -ne 0 ]; then
    echo "失败，"
    apt-get install libcurl4-gnutls-dev
    echo "开始安装cmake3.10.2"
#     wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/cmake-3.10.2.tar.gz
    wget https://raw.githubusercontent.com/lihuate/opencv4.1.0-raspbian-install/master/cmake-3.10.2.tar.gz
    tar -xzf cmake-3.9.0.tar.gz
    cd cmake-3.9.0/
#     ./bootstrap --system-curl
#     make -j2 && make install
    sudo apt remove cmake
    sudo make install
else

echo `cmake -version` > e.txt
path=`cut -d ' ' -f 3 e.txt`
rm -rf e.txt
if [[ $path =~ "3.9.0" ]] ; then
    echo "安装成功"
    echo "cmake版本及库信息："
    echo cmake版本 $path
else
echo "失败，请手动cmake1.10.X以上版本"
fi


rm -rf cmake-3.10.2.tar.gz
cd ..
rm -rf cmake-3.10.2/
