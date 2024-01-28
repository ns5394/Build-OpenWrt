#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: nies
#=================================================

# 添加额外软件包
#echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >> openwrt/feeds.conf.default
#echo 'src-git small https://github.com/kenzok8/small' >> openwrt/feeds.conf.default

# 更改默认IP地址
sed -i 's/192.168.1.1/192.168.5.1/g' openwrt/package/base-files/files/bin/config_generate
# 更改设备名
sed -i 's/OpenWrt/N4100/g' openwrt/package/base-files/files/bin/config_generate

# 设置密码为991016
sed -i 's|^root:::0:99999:7:::|root:$1$0JEhwicN$y./59TClu6QWLU3lAwJWi/:19733:0:99999:7:::|' openwrt/package/base-files/files/etc/shadow

# 更改Argone主题背景
cp -f $GITHUB_WORKSPACE/customize/mages/bg1.jpg openwrt/feeds/kenzo/luci-theme-argone/htdocs/luci-static/argone/img/bg1.jpg

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
#sed -i 's/nas/services/g; s/NAS/Services/g' openwrt/feeds/kenzo/luci-app-alist/luasrc/controller/alist.lua
#sed -i 's/nas/services/g' openwrt/feeds/kenzo/luci-app-alist/luasrc/view/alist/alist_status.htm
