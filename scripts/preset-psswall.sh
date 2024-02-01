#!/bin/bash

mkdir -p files/usr/bin

Brook_URL="https://github.com/txthinking/brook/releases/latest/download/brook_linux_arm64"
Hysteria_URL="https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-arm64"
ChinaDNS_URL="https://github.com/zfl9/chinadns-ng/releases/latest/download/chinadns-ng-aarch64"
TrojanGo_URL="https://github.com/p4gefau1t/trojan-go/releases/latest/download/trojan-go-linux-arm.zip"
Xray_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-arm64-v8a.zip"


wget -qO- $Brook_URL > files/usr/bin/brook
wget -qO- $Hysteria_URL > files/usr/bin/hysteria
wget -qO- $ChinaDNS_URL > files/usr/bin/chinadns-ng

wget -O trojan-go.zip $TrojanGo_URL
unzip trojan-go.zip trojan-go -d files/usr/bin
rm -rf trojan-go.zip

wget -O xray.zip $Xray_URL
unzip xray.zip xray -d files/usr/bin
rm -rf xray.zip

LATEST_SingBox=$(curl -sI "https://github.com/SagerNet/sing-box/releases/latest" | grep -i "location:" | awk -F "/" '{gsub(/^v/, "", $NF); print $NF}' | tr -d '\r')
wget -O "sing-box-${LATEST_SingBox}-linux-arm64.tar.gz" "https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-${LATEST_SingBox}-linux-arm64.tar.gz"
tar xzf sing-box-${LATEST_SingBox}-linux-arm64.tar.gz
mv sing-box-${LATEST_SingBox}-linux-arm64/sing-box files/usr/bin/
rm -rf sing-box-${LATEST_SingBox}-linux-arm64 && rm -rf sing-box-${LATEST_SingBox}-linux-arm64.tar.gz

chmod +x files/usr/bin/*

cd files/usr/bin
ls
