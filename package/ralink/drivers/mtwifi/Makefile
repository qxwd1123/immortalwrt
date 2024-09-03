#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=mtwifi
PKG_VERSION:=1
PKG_RELEASE:=2

PKG_CONFIG_DEPENDS := \
	CONFIG_RALINK_CHIP_MT7603E_MT7612E \
	CONFIG_RALINK_CHIP_MT7603E_MT7615E \
	CONFIG_RALINK_CHIP_MT7615E \
	CONFIG_RALINK_CHIP_MT7615E_DBDC \
	CONFIG_RALINK_CHIP_MT7915E_DBDC

include $(INCLUDE_DIR)/package.mk

define Package/mtwifi
  SECTION:=net
  CATEGORY:=Network
  TITLE:=RALINK wifi AP config
  DEPENDS:=@TARGET_ralink +wireless-tools
  CONFLICTS:=kmod-mt7615d_dbdc
  SUBMENU:=Wireless
endef

define Package/mtwifi/config
	source "$(SOURCE)/config.in"
endef

define Package/mtwifi/description
  MTWiFi auto config for mt7603/mt7612/mt7615 chips
endef

define Build/Compile
endef

define Package/mtwifi/install
	$(INSTALL_DIR) $(1)/etc/init.d/
	$(INSTALL_DIR) $(1)/lib/wifi/
	$(INSTALL_DIR) $(1)/etc/wireless/mt7615/
	$(INSTALL_DIR) $(1)/etc_ro/Wireless/RT2860AP/
	$(INSTALL_DIR) $(1)/lib/preinit/
ifeq ($(CONFIG_RALINK_CHIP_MT7603E_MT7612E),y)
	$(INSTALL_BIN) ./files/7603_7612-l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_BIN) ./files/mt7603.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_BIN) ./files/mt7612.dat $(1)/etc/wireless/mt7615/mt7615.2.dat
else ifeq ($(CONFIG_RALINK_CHIP_MT7603E_MT7615E),y)
	$(INSTALL_BIN) ./files/7603_7615-l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_BIN) ./files/mt7603.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_BIN) ./files/mt7615.dat $(1)/etc/wireless/mt7615/mt7615.2.dat
else ifeq ($(CONFIG_RALINK_CHIP_MT7615E_DBDC),y)
	$(INSTALL_BIN) ./files/7615d.l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_BIN) ./files/mt7615.1.2G.dat $(1)/etc/wireless/mt7615/
	$(INSTALL_BIN) ./files/mt7615.1.5G.dat $(1)/etc/wireless/mt7615/
else ifeq ($(CONFIG_RALINK_CHIP_MT7915E_DBDC),y)
	$(INSTALL_BIN) ./files/7915d.l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_BIN) ./files/mt7915.1.2G.dat $(1)/etc/wireless/mt7615/
	$(INSTALL_BIN) ./files/mt7915.1.5G.dat $(1)/etc/wireless/mt7615/
else
	$(INSTALL_BIN) ./files/7615.l1profile.dat $(1)/etc/wireless/l1profile.dat
	$(INSTALL_BIN) ./files/mt7615.2G.dat $(1)/etc/wireless/mt7615/mt7615.1.dat
	$(INSTALL_BIN) ./files/mt7615.5G.dat $(1)/etc/wireless/mt7615/mt7615.2.dat
endif
	$(INSTALL_BIN) ./files/SingleSKU.dat $(1)/etc_ro/Wireless/RT2860AP/
	$(INSTALL_BIN) ./files/SingleSKU_BF.dat $(1)/etc_ro/Wireless/RT2860AP/
	$(INSTALL_BIN) ./files/mt7615.lua $(1)/lib/wifi
	$(INSTALL_BIN) ./files/firmware.sh $(1)/etc/init.d/
	$(INSTALL_BIN) ./files/91_load_wifi.sh $(1)/lib/preinit/
endef

$(eval $(call BuildPackage,mtwifi))
