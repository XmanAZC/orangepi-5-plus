---
这是一个orangepi-5-plus从零到一的实现项目，项目聚焦于从bootrom到rootfs再到ROS2。
---

## 编译
todo:

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
