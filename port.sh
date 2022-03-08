#!/bin/bash

mkdir -p pkg/opt/libfprint
mkdir -p pkg/etc/ld.so.conf.d

dpkg-deb -x libfprint_2_2_1_90_1+tod1_0ubuntu120_04_2_amd64_16c6e64404f8411.deb pkg/opt/libfprint
deps=($(readelf -d pkg/opt/libfprint/usr/lib/x86_64-linux-gnu/libfprint-2.so.2.0.0 | grep 'NEEDED' | cut -d "[" -f2 | cut -d "]" -f1))


for i in "${deps[@]}"; do
  echo $i
  find /usr -name $i -exec rsync -ap -L --relative {} pkg/opt/libfprint \;
  echo "/opt/libfprint/usr/lib/x86_64-linux-gnu/${i}" >> pkg/etc/ld.so.conf.d/libfprint-2.so.2.conf
done

if [[ -d pkg/opt/libfprint/usr/lib/firefox ]]; then 
    sudo rm -rf pkg/opt/libfprint/usr/lib/firefox
fi
if [[ -d pkg/opt/libfprint/usr/lib/thunderbird ]]; then 
    sudo rm -rf pkg/opt/libfprint/usr/lib/thunderbird
fi

