#!/QOpenSys/pkgs/bin/bash


tmp=$(mktemp -d)
echo $tmp
cd $tmp
curl -L -o main.tar.gz https://github.com/TongkunZhang/bob-release-tools/archive/refs/heads/main.tar.gz
tar -xzf main.tar.gz
cd bob-release-tools-main

make rpm
make upload

cd /tmp
rm -rf $tmp
