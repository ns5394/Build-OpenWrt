#!/bin/bash

ARCH="${1}"

mkdir -p files/usr/bin

Brook_URL="https://github.com/txthinking/brook/releases/latest/download/brook_linux_${ARCH}"
Hysteria_URL="https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-${ARCH}"
wget -qO- $Brook_URL > files/usr/bin/brook
wget -qO- $Hysteria_URL > files/usr/bin/hysteria

LATEST_SingBox=$(curl -sI "https://github.com/SagerNet/sing-box/releases/latest" | grep -i "location:" | awk -F "/" '{gsub(/^v/, "", $NF); print $NF}' | tr -d '\r')

# 根据不同的架构执行不同的命令
if [ "${ARCH}" == "amd64" ]; then
  ChinaDNS_URL="https://github.com/zfl9/chinadns-ng/releases/latest/download/chinadns-ng@x86_64-linux-musl@x86_64@fast+lto"
  TrojanGo_URL="https://github.com/p4gefau1t/trojan-go/releases/latest/download/trojan-go-linux-${ARCH}.zip"
  Xray_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip"
  SINGBOX_URL="https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-${LATEST_SingBox}-linux-${ARCH}.tar.gz"
elif [ "${ARCH}" == "arm64" ]; then
  ChinaDNS_URL="https://github.com/zfl9/chinadns-ng/releases/latest/download/chinadns-ng-aarch64"
  TrojanGo_URL="https://github.com/p4gefau1t/trojan-go/releases/latest/download/trojan-go-linux-armv8.zip"
  Xray_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-${ARCH}-v8a.zip"
  SINGBOX_URL="https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-${LATEST_SingBox}-linux-${ARCH}.tar.gz"
fi
wget -qO- $ChinaDNS_URL > files/usr/bin/chinadns-ng

wget -O trojan-go.zip $TrojanGo_URL
unzip trojan-go.zip trojan-go -d files/usr/bin
rm -rf trojan-go.zip

wget -O xray.zip $Xray_URL
unzip xray.zip xray -d files/usr/bin
rm -rf xray.zip

# 下载最新版本的 sing-box------------------------------
wget -O "sing-box-${LATEST_SingBox}-linux-${ARCH}.tar.gz" "$SINGBOX_URL"
tar xzf sing-box-${LATEST_SingBox}-linux-${ARCH}.tar.gz
mv sing-box-${LATEST_SingBox}-linux-${ARCH}/sing-box files/usr/bin/
rm -rf sing-box-${LATEST_SingBox}-linux-${ARCH} && rm -rf sing-box-${LATEST_SingBox}-linux-${ARCH}.tar.gz


chmod +x files/usr/bin/*

cd files/usr/bin
ls
