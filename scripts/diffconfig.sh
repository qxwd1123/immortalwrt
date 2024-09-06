#!/bin/sh
make ./scripts/config/conf >/dev/null || { make ./scripts/config/conf; exit 1; }
grep \^CONFIG_TARGET_ .config${TASKNAME_SUFFIX} | head -n3 > tmp/.diffconfig.head
grep \^CONFIG_TARGET_DEVICE_ .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_ALL=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_ALL_KMODS=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_ALL_NONSHARED=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_DEVEL=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_TOOLCHAINOPTS=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_BUSYBOX_CUSTOM=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
grep '^CONFIG_TARGET_PER_DEVICE_ROOTFS=y' .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
./scripts/config/conf --defconfig=tmp/.diffconfig.head -w tmp/.diffconfig.stage1 Config.in >/dev/null
./scripts/kconfig.pl '>+' tmp/.diffconfig.stage1 .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
./scripts/config/conf --defconfig=tmp/.diffconfig.head -w tmp/.diffconfig.stage2 Config.in >/dev/null
./scripts/kconfig.pl '>' tmp/.diffconfig.stage2 .config${TASKNAME_SUFFIX} >> tmp/.diffconfig.head
cat tmp/.diffconfig.head
rm -f tmp/.diffconfig tmp/.diffconfig.head
