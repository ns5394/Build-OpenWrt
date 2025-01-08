#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: nies
#=================================================

# 添加额外软件包
git clone https://github.com/kenzok8/openwrt-packages openwrt/kenzo
git clone https://github.com/kenzok8/small openwrt/small
rm -rf openwrt/kenzo/luci-theme-argon
mv -f openwrt/kenzo/* openwrt/package/
mv -f openwrt/small/* openwrt/package/
rm -rf openwrt/kenzo
rm -rf openwrt/small

# 更改默认IP地址
# sed -i 's/192.168.1.1/192.168.5.3/g' openwrt/package/base-files/files/bin/config_generate
# sed -i 's/192.168.1.1/192.168.5.3/g' openwrt/package/base-files/luci2/bin/config_generate
sed -i \
    -e 's/192\.168\.1\.1/192.168.5.3/' \
    -e '/set network\.\$1\.netmask/a\    set network.$1.gateway='\''192.168.5.1'\''' \
    -e '/set network\.\$1\.gateway/a\    set network.$1.dns='\''223.5.5.5'\''' \
    openwrt/package/base-files/luci2/bin/config_generate
sed -i \
    -e 's/192.168.1.1/192.168.5.3/' \
    -e '/set network\.\$1\.netmask/a\    set network.$1.gateway='\''192.168.5.1'\''' \
    -e '/set network\.\$1\.gateway/a\    set network.$1.dns='\''223.5.5.5'\''' \
    openwrt/package/base-files/files/bin/config_generate


# 更改设备名
sed -i 's/LEDE/OpenWrt/g' openwrt/package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' openwrt/package/base-files/luci2/bin/config_generate


# 清除默认登录密码
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings

# 更改Argone主题背景 设为默认
cp -f $GITHUB_WORKSPACE/customize/images/bg1.jpg openwrt/package/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg
sed -i 's/bootstrap/argon/g' openwrt/feeds/luci/collections/luci/Makefile
sed -i 's/bootstrap/argon/g' openwrt/feeds/luci/collections/luci-light/Makefile

# 更改banner
cp -f $GITHUB_WORKSPACE/customize/diy/banner openwrt/package/base-files/files/etc/banner

# x86 型号只显示 CPU 型号
sed -i 's/${g}.*/${a}${b}${c}${d}${e}${f}${hydrid}/g' openwrt/package/lean/autocore/files/x86/autocore

# 修改版本为编译日期
date_version=$(date +"%y.%m.%d")
orig_version=$(cat "openwrt/package/lean/default-settings/files/zzz-default-settings" | grep DISTRIB_REVISION= | awk -F "'" '{print $2}')
sed -i "s/${orig_version}/R${date_version} by NIES/g" openwrt/package/lean/default-settings/files/zzz-default-settings

# TTYD 自动登录
sed -i 's|/bin/login|/bin/login -f root|g' openwrt/feeds/packages/utils/ttyd/files/ttyd.config

# 修改本地时间格式
sed -i 's/os.date()/os.date("%a %Y-%m-%d %H:%M:%S")/g' openwrt/package/lean/autocore/files/*/index.htm

# 调整 ZeroTier 到 服务 菜单
#sed -i 's/vpn/services/g; s/VPN/Services/g' openwrt/feeds/luci/applications/luci-app-zerotier/luasrc/controller/zerotier.lua
#sed -i 's/vpn/services/g' openwrt/feeds/luci/applications/luci-app-zerotier/luasrc/view/zerotier/zerotier_status.htm

# 调整alist到 服务 菜单
# sed -i 's/nas/services/g; s/NAS/Services/g' openwrt/package/luci-app-alist/luasrc/controller/alist.lua
# sed -i 's/nas/services/g' openwrt/package/luci-app-alist/luasrc/view/alist/alist_status.htm
