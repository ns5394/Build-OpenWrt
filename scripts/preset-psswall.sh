#!/bin/bash

mkdir -p files/usr/bin

Brook_URL="https://github.com/txthinking/brook/releases/latest/download/brook_linux_arm64"
Hysteria_URL="https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-arm64"
ChinaDNS_URL="https://github.com/zfl9/chinadns-ng/releases/latest/download/chinadns-ng-aarch64"
TrojanGo_URL="https://github.com/p4gefau1t/trojan-go/releases/latest/download/trojan-go-linux-arm.zip"
Xray_URL="https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-arm64-v8a.zip"
SingBox_URL="https://github.com/SagerNet/sing-box/releases/latest/download/sing-box-1.8.4-linux-arm64.tar.gz"

wget -qO- $Brook_URL > files/usr/bin/brook
wget -qO- $Hysteria_URL > files/usr/bin/hysteria
wget -qO- $ChinaDNS_URL > files/usr/bin/chinadns-ng
wget -qO- $TrojanGo_URL | unzip -p - ./trojan-go > files/usr/bin/trojan-go
wget -qO- $Xray_URL | unzip -p - ./xray > files/usr/bin/xray
wget -qO- $SingBox_URL | tar xOvz > files/usr/bin/sing-box

chmod +x files/usr/bin/*
