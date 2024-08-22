# Copyright (c) 2015 OpenWrt.org
#
include $(TOPDIR)/rules.mk

ARCH:=arm
BOARD:=mtk
BOARDNAME:=MediaTek Ralink ARM SDK Version
SUBTARGETS:=mt7622 mt7623 mt7629 mt7986 mt7981
FEATURES:=squashfs nand emmc ramdisk fpu

KERNEL_PATCHVER:=5.4
KERNEL_TESTING_PATCHVER:=5.4

include $(INCLUDE_DIR)/target.mk
DEFAULT_PACKAGES += \
	kmod-leds-gpio kmod-gpio-button-hotplug \
	autocore uboot-envtools mtk-smp zoneinfo-core zoneinfo-asia

$(eval $(call BuildTarget))
