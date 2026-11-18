#!/usr/bin/env bash
set -euo pipefail
ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)

${ROOT}/tools/rk3588-upgrade db ${ROOT}/rk3588_loader_v1.24.100.bin
sleep 1
${ROOT}/tools/rk3588-upgrade wl 0 ${ROOT}/output/uboot-emmc.img
${ROOT}/tools/rk3588-upgrade rd