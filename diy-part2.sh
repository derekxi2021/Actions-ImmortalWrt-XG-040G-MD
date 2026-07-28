#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# set golang 1.26.x （rc/beta）
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/kenzok8/golang -b 1.26 feeds/packages/lang/golang

# 自动修改 an7581.mk 同时输出 UBI 和 Squashfs
python3 -c '
with open("target/linux/airoha/image/an7581.mk", "r") as f:
    c = f.read()
old = """  IMAGES := factory.bin sysupgrade.bin\n  IMAGE/factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-ubi"""
new = """  IMAGES := ubi-factory.bin squashfs-factory.bin sysupgrade.bin\n  IMAGE/ubi-factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-ubi\n  IMAGE/squashfs-factory.bin := append-kernel | pad-to $$$$(KERNEL_SIZE) | append-rootfs | pad-rootfs"""
if old in c:
    with open("target/linux/airoha/image/an7581.mk", "w") as f:
        f.write(c.replace(old, new))
'
