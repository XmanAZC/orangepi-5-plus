#!/usr/bin/env bash
set -euo pipefail

ROOT=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
CROSS_COMPILE="$ROOT/toolchain/gcc-arm-11.2-2022.02-x86_64-aarch64-none-linux-gnu/bin/aarch64-none-linux-gnu-"
BL31="$ROOT/blobs/rk3588_bl31_v1.56.elf"
DDR="$ROOT/blobs/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.15.bin"
JOBS=${JOBS:-$(nproc)}
OUTPUT="$ROOT/output/uboot-emmc.img"

for file in "${CROSS_COMPILE}gcc" "$BL31" "$DDR"; do
    [[ -f $file ]] || { echo "Missing: $file" >&2; exit 1; }
done

cd "$ROOT/u-boot"
make orangepi_5_plus_defconfig
make -j"$JOBS" CROSS_COMPILE="$CROSS_COMPILE" BL31="$BL31" \
    spl/u-boot-spl.bin u-boot.dtb u-boot.itb
# Rockchip FIT 生成器的解码器失败时可能静默遗漏 BL31，因此检查结果。
tools/dumpimage -l u-boot.itb | grep -q 'ARM Trusted Firmware' || {
    echo 'FIT is missing BL31' >&2; exit 1;
}
tools/mkimage -n rk3588 -T rksd -d "$DDR:spl/u-boot-spl.bin" idbloader.img

mkdir -p "$ROOT/output"
tmp=$(mktemp "$ROOT/output/.uboot-emmc.XXXXXXXX")
trap 'rm -f -- "$tmp"' EXIT
# 按 eMMC 扇区布局写入启动加载器和 U-Boot FIT。
python3 "$ROOT/create_emmc_image.py" "$tmp" idbloader.img u-boot.itb
mv -f -- "$tmp" "$OUTPUT"
trap - EXIT
printf '\nGenerated: %s\n' "$OUTPUT"
printf 'eMMC: idbloader sector 64; U-Boot FIT sector 16384; bootdelay=-1\n'
