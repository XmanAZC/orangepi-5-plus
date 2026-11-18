---
基于orangepi-5-plus开发板，项目聚焦于从bootrom到rootfs再到ROS2。
---

## 编译

```
git clone https://github.com/XmanAZC/orangepi-5-plus.git
cd orangepi-5-plus
git submodule update --init --recursive
./build.sh
```

## 刷写
将oragnepi-5-plus进入mashrom模式，**注意：我使用的硬件是orangepi-5-plus(8GB RAM,64GB emmc)其他版本没测试过。后续获取会使用orangepi-5板子。**
```
./flash-mmc.sh
```

## rkbin
rkbin 仓库主要用于存放 Rockchip 平台上前级启动阶段可能用到的文件，仓库来自GitHub上瑞芯微。

其中`rk3588_loader_v1.24.100.bin`文件通过以下命令生成
```bash
cd rkbin
tools/boot_merger RKBOOT/RK3588MINIALL_V5.ini
mv rk3588_loader_v1.24.100.bin ../
```

## u-boot
使用 GitHub上预发布的v2027.01-rc2，基于这个tag会有些更改。

## kernel
基于`https://github.com/orangepi-xunlong/linux-orangepi.git`中的`f046287`提交，可能会做些更改。
