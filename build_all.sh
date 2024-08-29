#!/bin/bash

#to debug
#set -x

MY_VERSION=$(cat VERSION)
P_URL="https://github.com/simple64/simple64/archive/refs/tags/v${MY_VERSION}.tar.gz"
#P_NAME=$(echo $P_URL | cut -d/ -f5)
P_NAME="simple64"
P_VERSION=${MY_VERSION}
P_FILENAME=$(echo $P_URL | cut -d/ -f9)
WORKDIR="workdir"

#=================================================
die() { echo >&2 "$*"; exit 1; };
#=================================================

#echo "P_NAME: ${P_NAME}"
#echo "P_VERSION: ${P_VERSION}"
#echo "P_FILENAME: ${P_FILENAME}"

#exit;


#add-apt-repository ppa:mystic-mirage/pycharm -y

#-------------------------------------------------
#dpkg --add-architecture i386
sudo apt update
sudo apt install -y wget file bzip2 build-essential ninja-build
#-------------------------------------------------
pkgcachedir='/tmp/.pkgdeploycache'
mkdir -p ${pkgcachedir}

packages_to_install="libpng-dev libsdl2-dev libsdl2-net-dev libhidapi-dev libvulkan-dev qt6-base-dev qt6-websockets-dev"
packages_to_download="libcurl3t64-gnutls libssh-4 libldap2 libsasl2-2 libc6 libglib2.0-dev libglib2.0-0t64 libgssapi-krb5-2 libicu74 libkrb5-3 libk5crypto3 libkrb5support0 librtmp1 libselinux1 libxcb-cursor0 libpcre2-16-0 libx11-xcb-dev"
packages_to_download_extra_qt6="libb2-1 libdouble-conversion3 libgl-dev libglx-dev libmd4c0 libopengl-dev libqt6concurrent6t64 libqt6core5compat6 libqt6core6t64 libqt6dbus6t64 libqt6gui6t64 libqt6network6t64 libqt6opengl6t64 libqt6openglwidgets6t64 libqt6printsupport6t64 libqt6qml6 libqt6qmlmodels6 libqt6quick6 libqt6sql6-sqlite libqt6sql6t64 libqt6test6t64 libqt6waylandclient6 libqt6waylandcompositor6 libqt6waylandeglclienthwintegration6 libqt6waylandeglcompositorhwintegration6 libqt6widgets6t64 libqt6wlshellintegration6 libqt6xml6t64 libts0t64 qmake6 qmake6-bin qt6-5compat-dev qt6-base-dev-tools qt6-gtk-platformtheme qt6-qpa-plugins qt6-translations-l10n qt6-wayland"

#sudo apt-get reinstall --download-only ${packages_to_install} ${packages_to_download} ${packages_to_download_extra_qt6} || die "* Cant download package deps!"

#cp /var/cache/apt/archives/*.deb ${pkgcachedir}

#-------------------------------------------------
sudo apt install -y ${packages_to_install} || die "* Cant install package dev!"
#######-------#######-------#######-------#######-------#######-------#######-------#######-------

# Get simple64 code
wget -nv ${P_URL}

tar xf v${MY_VERSION}.tar.gz || die "* Cant extract source code!"

cd simple64-${MY_VERSION} || die "* Cant enter the source dir!"

./clean.sh || die "* Cant clean compilated!"

####### POG #######
#sed -i 's/wget -q/wget -c/g' build.sh
#sed -i 's/cmake/#cmake/g' build.sh
#sed -i 's/set -e/set -x/g' build.sh
#echo "exit 0" >> build.sh
####### END POG #######

./build.sh || die "* Cant build the source!"


cd ..
#######-------#######-------#######-------#######-------#######-------#######-------#######-------

exit 0
