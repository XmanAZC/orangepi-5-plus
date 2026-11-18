#!/usr/bin/env bash
set -euo pipefail
rk3588-upgrade db /home/phil/tmp/MiniLoaderAll.bin
sleep 1
rk3588-upgrade wl 0 output/uboot-emmc.img
rk3588-upgrade rd