#!/bin/bash

kver="4.19.94"

sed -e "s/-uname-r//g" -i ~/rpmbuild/SPECS/kernel.spec
sed -e "s/xorg-x11-drv-vmmouse < 14.0.0/xorg-x11-drv-vmmouse < 13.0.99/g" -i ~/rpmbuild/SPECS/kernel.spec
sed -e "s/rpm < 4.13.0.1-19/rpm < 4.11.3-48/g" -i ~/rpmbuild/SPECS/kernel.spec

if [[ -z $(cat ~/rpmbuild/SPECS/kernel.spec | grep "Added IMQ patch") ]]; then
sed -i "/%changelog/ a \
* Tue Aug 20 2024 <khvalera@ukr.net> - $kver\
- Added IMQ patch\
" ~/rpmbuild/SPECS/kernel.spec
fi

if [[ -z $(cat ~/rpmbuild/SPECS/kernel.spec | grep "Patch80000") ]]; then
sed -i '/Patches needed for building this package/ a \
\
# ClearOS patches (80000+)\
Patch80000: linux-5.4-imq.patch\
# end of ClearOS patches\
' ~/rpmbuild/SPECS/kernel.spec
fi

FIX_CONFIG_IMQ(){
local file_fix=$1
if [[ -z $(cat $file_fix | grep "CONFIG_IMQ") ]]; then
sed -i '/CONFIG_NET_POLL_CONTROLLER=y/ a \
CONFIG_IMQ=m\
# CONFIG_IMQ_BEHAVIOR_AA is not set\
CONFIG_IMQ_BEHAVIOR_AB=y\
# CONFIG_IMQ_BEHAVIOR_BA is not set\
# CONFIG_IMQ_BEHAVIOR_BB is not set\
CONFIG_IMQ_NUM_DEVS=16' $file_fix
fi
}

FIX_CONFIG_NETFILTER_XT_TARGET_IMQ(){
local file_fix=$1
if [[ -z $(cat $file_fix | grep "CONFIG_NETFILTER_XT_TARGET_IMQ") ]]; then
sed -i '/CONFIG_NETFILTER_XT_TARGET_NETMAP=m/ i \
CONFIG_NETFILTER_XT_TARGET_IMQ=m' $file_fix
fi
}

FIX_CONFIG_IGC(){
local file_fix=$1
if [[ -z $(cat $file_fix | grep "CONFIG_IGC") ]]; then
sed -i '/CONFIG_IGBVF=m/ a \
CONFIG_IGC=m' $file_fix
fi
}

for file in `find ~/rpmbuild/SOURCES -type f -name "*.config"`
do
   FIX_CONFIG_IMQ $file
   FIX_CONFIG_NETFILTER_XT_TARGET_IMQ $file
   FIX_CONFIG_IGC $file
done
