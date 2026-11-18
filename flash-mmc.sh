#!/usr/bin/env bash
set -euo pipefail
rkbin/tools/rkdeveloptool db rk3588_loader_v1.24.100.bin
sleep 1
rkbin/tools/rkdeveloptool wl 0 output/uboot-emmc.img
rkbin/tools/rkdeveloptool rd