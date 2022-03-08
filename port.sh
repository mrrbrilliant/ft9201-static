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

rsync -ap -L /lib/x86_64-linux-gnu/libglib-2.0.so.0 \
    /lib/x86_64-linux-gnu/libgio-2.0.so.0 \
    /lib/x86_64-linux-gnu/libgobject-2.0.so.0 \
    /lib/x86_64-linux-gnu/libgmodule-2.0.so.0 \
    /lib/x86_64-linux-gnu/libfprint-2.so.2 \
    /lib/x86_64-linux-gnu/libpolkit-gobject-1.so.0 \
    /lib/x86_64-linux-gnu/libc.so.6 \
    /lib/x86_64-linux-gnu/libpcre.so.3 \
    /lib/x86_64-linux-gnu/libpthread.so.0 \
    /lib/x86_64-linux-gnu/libz.so.1 \
    /lib/x86_64-linux-gnu/libdl.so.2 \
    /lib/x86_64-linux-gnu/libmount.so.1 \
    /lib/x86_64-linux-gnu/libselinux.so.1 \
    /lib/x86_64-linux-gnu/libresolv.so.2 \
    /lib/x86_64-linux-gnu/libffi.so.7 \
    /lib/x86_64-linux-gnu/libgusb.so.2 \
    /lib/x86_64-linux-gnu/libpixman-1.so.0 \
    /lib/x86_64-linux-gnu/libm.so.6 \
    /lib/x86_64-linux-gnu/libnss3.so \
    /lib/x86_64-linux-gnu/libsystemd.so.0 \
    /lib64/ld-linux-x86-64.so.2 \
    /lib/x86_64-linux-gnu/libblkid.so.1 \
    /lib/x86_64-linux-gnu/libpcre2-8.so.0 \
    /lib/x86_64-linux-gnu/libusb-1.0.so.0 \
    /lib/x86_64-linux-gnu/libnssutil3.so \
    /lib/x86_64-linux-gnu/libplc4.so \
    /lib/x86_64-linux-gnu/libplds4.so \
    /lib/x86_64-linux-gnu/libnspr4.so \
    /lib/x86_64-linux-gnu/librt.so.1 \
    /lib/x86_64-linux-gnu/liblzma.so.5 \
    /lib/x86_64-linux-gnu/liblz4.so.1 \
    /lib/x86_64-linux-gnu/libgcrypt.so.20 \
    /lib/x86_64-linux-gnu/libudev.so.1 \
    /lib/x86_64-linux-gnu/libgpg-error.so.0 \
    pkg/opt/libfprint/usr/lib/x86_64-linux-gnu