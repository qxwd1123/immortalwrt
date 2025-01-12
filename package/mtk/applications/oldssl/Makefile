#
# Copyright (C) 2006-2016 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=oldssl
PKG_BASE:=1.1.1
PKG_BUGFIX:=w
PKG_VERSION:=$(PKG_BASE)$(PKG_BUGFIX)
PKG_RELEASE:=1
PKG_USE_MIPS16:=0
ENGINES_DIR=engines-1.1

PKG_BUILD_PARALLEL:=1

PKG_SOURCE:=openssl-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL_FILE:=$(PKG_SOURCE)
PKG_SOURCE_URL:= \
	https://mirrors.tencent.com/oldssl/source/ \
	https://mirrors.tencent.com/openssl/source/ \
	https://mirrors.tencent.com/openssl/source/old/$(PKG_BASE)/ \
	https://www.openssl.org/source/ \
	https://www.openssl.org/source/old/$(PKG_BASE)/ \
	https://ftp.fi.muni.cz/pub/openssl/source/ \
	https://ftp.fi.muni.cz/pub/openssl/source/old/$(PKG_BASE)/ \
	ftp://ftp.pca.dfn.de/pub/tools/net/openssl/source/ \
	ftp://ftp.pca.dfn.de/pub/tools/net/openssl/source/old/$(PKG_BASE)/

PKG_HASH:=cf3098950cb4d853ad95c0841f1f9c6d3dc102dccfcacd521d93925208b76ac8

PKG_LICENSE:=OpenSSL
PKG_LICENSE_FILES:=LICENSE
PKG_MAINTAINER:=Eneas U de Queiroz <cotequeiroz@gmail.com>
PKG_CPE_ID:=cpe:/a:openssl:openssl
PKG_CONFIG_DEPENDS:= \
	CONFIG_OLDSSL_ENGINE \
	CONFIG_OLDSSL_ENGINE_BUILTIN \
	CONFIG_OLDSSL_ENGINE_BUILTIN_AFALG \
	CONFIG_OLDSSL_ENGINE_BUILTIN_DEVCRYPTO \
	CONFIG_OLDSSL_ENGINE_BUILTIN_PADLOCK \
	CONFIG_OLDSSL_NO_DEPRECATED \
	CONFIG_OLDSSL_OPTIMIZE_SPEED \
	CONFIG_OLDSSL_PREFER_CHACHA_OVER_GCM \
	CONFIG_OLDSSL_WITH_ARIA \
	CONFIG_OLDSSL_WITH_ASM \
	CONFIG_OLDSSL_WITH_ASYNC \
	CONFIG_OLDSSL_WITH_BLAKE2 \
	CONFIG_OLDSSL_WITH_CAMELLIA \
	CONFIG_OLDSSL_WITH_CHACHA_POLY1305 \
	CONFIG_OLDSSL_WITH_CMS \
	CONFIG_OLDSSL_WITH_COMPRESSION \
	CONFIG_OLDSSL_WITH_DTLS \
	CONFIG_OLDSSL_WITH_EC2M \
	CONFIG_OLDSSL_WITH_ERROR_MESSAGES \
	CONFIG_OLDSSL_WITH_GOST \
	CONFIG_OLDSSL_WITH_IDEA \
	CONFIG_OLDSSL_WITH_MDC2 \
	CONFIG_OLDSSL_WITH_NPN \
	CONFIG_OLDSSL_WITH_PSK \
	CONFIG_OLDSSL_WITH_RFC3779 \
	CONFIG_OLDSSL_WITH_SEED \
	CONFIG_OLDSSL_WITH_SM234 \
	CONFIG_OLDSSL_WITH_SRP \
	CONFIG_OLDSSL_WITH_SSE2 \
	CONFIG_OLDSSL_WITH_TLS13 \
	CONFIG_OLDSSL_WITH_WHIRLPOOL

include $(INCLUDE_DIR)/package.mk

ifneq ($(CONFIG_CCACHE),)
HOSTCC=$(HOSTCC_NOCACHE)
HOSTCXX=$(HOSTCXX_NOCACHE)
endif

define Package/oldssl/Default
  TITLE:=Open source SSL toolkit
  URL:=http://www.openssl.org/
  SECTION:=libs
  CATEGORY:=Libraries
endef

define Package/liboldssl/config
source "$(SOURCE)/Config.in"
endef

define Package/oldssl/Default/description
The OpenSSL Project is a collaborative effort to develop a robust,
commercial-grade, full-featured, and Open Source toolkit implementing the
Transport Layer Security (TLS) protocol as well as a full-strength
general-purpose cryptography library.
endef

define Package/liboldssl
$(call Package/oldssl/Default)
  SUBMENU:=SSL
  DEPENDS:=+OLDSSL_WITH_COMPRESSION:zlib \
	   +OLDSSL_ENGINE_BUILTIN_AFALG:kmod-crypto-user \
	   +OLDSSL_ENGINE_BUILTIN_DEVCRYPTO:kmod-cryptodev \
	   +OLDSSL_ENGINE_BUILTIN_PADLOCK:kmod-crypto-hw-padlock
  TITLE+= (libraries)
  ABI_VERSION:=1.1
  MENU:=1
endef

define Package/liboldssl/description
$(call Package/oldssl/Default/description)
This package contains the OpenSSL shared libraries, needed by other programs.
endef

define Package/oldssl-util
  $(call Package/oldssl/Default)
  SECTION:=utils
  CATEGORY:=Utilities
  DEPENDS:=+liboldssl +liboldssl-conf
  TITLE+= (utility)
endef

define Package/oldssl-util/description
$(call Package/oldssl/Default/description)
This package contains the OpenSSL command-line utility.
endef

define Package/liboldssl-conf
  $(call Package/oldssl/Default)
  SUBMENU:=SSL
  TITLE:=/etc/oldssl/openssl.cnf config file
  DEPENDS:=liboldssl
endef

define Package/liboldssl-conf/conffiles
/etc/oldssl/openssl.cnf
endef

define Package/liboldssl-conf/description
$(call Package/oldssl/Default/description)
This package installs the OpenSSL configuration file /etc/oldssl/openssl.cnf.
endef

define Package/liboldssl-afalg
  $(call Package/oldssl/Default)
  SUBMENU:=SSL
  TITLE:=AFALG hardware acceleration engine
  DEPENDS:=liboldssl @OLDSSL_ENGINE @KERNEL_AIO \
	   +PACKAGE_liboldssl-afalg:kmod-crypto-user +liboldssl-conf @!OLDSSL_ENGINE_BUILTIN
endef

define Package/liboldssl-afalg/description
This package adds an engine that enables hardware acceleration
through the AF_ALG kernel interface.
To use it, you need to configure the engine in /etc/oldssl/openssl.cnf
See https://www.openssl.org/docs/man1.1.1/man5/config.html#Engine-Configuration-Module
and https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerators
The engine_id is "afalg"
endef

define Package/liboldssl-devcrypto
  $(call Package/oldssl/Default)
  SUBMENU:=SSL
  TITLE:=/dev/crypto hardware acceleration engine
  DEPENDS:=liboldssl @OLDSSL_ENGINE +PACKAGE_liboldssl-devcrypto:kmod-cryptodev +liboldssl-conf \
	   @!OLDSSL_ENGINE_BUILTIN
endef

define Package/liboldssl-devcrypto/description
This package adds an engine that enables hardware acceleration
through the /dev/crypto kernel interface.
To use it, you need to configure the engine in /etc/oldssl/openssl.cnf
See https://www.openssl.org/docs/man1.1.1/man5/config.html#Engine-Configuration-Module
and https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerators
The engine_id is "devcrypto"
endef

define Package/liboldssl-padlock
  $(call Package/oldssl/Default)
  SUBMENU:=SSL
  TITLE:=VIA Padlock hardware acceleration engine
  DEPENDS:=liboldssl @OLDSSL_ENGINE @TARGET_x86 +PACKAGE_liboldssl-padlock:kmod-crypto-hw-padlock \
	   +liboldssl-conf @!OLDSSL_ENGINE_BUILTIN
endef

define Package/liboldssl-padlock/description
This package adds an engine that enables VIA Padlock hardware acceleration.
To use it, you need to configure it in /etc/oldssl/openssl.cnf.
See https://www.openssl.org/docs/man1.1.1/man5/config.html#Engine-Configuration-Module
and https://openwrt.org/docs/techref/hardware/cryptographic.hardware.accelerators
The engine_id is "padlock"
endef

OLDSSL_OPTIONS:= shared

ifndef CONFIG_OLDSSL_WITH_BLAKE2
  OLDSSL_OPTIONS += no-blake2
endif

ifndef CONFIG_OLDSSL_WITH_CHACHA_POLY1305
  OLDSSL_OPTIONS += no-chacha no-poly1305
else
  ifdef CONFIG_OLDSSL_PREFER_CHACHA_OVER_GCM
    OLDSSL_OPTIONS += -DOLDSSL_PREFER_CHACHA_OVER_GCM
  endif
endif

ifndef CONFIG_OLDSSL_WITH_ASYNC
  OLDSSL_OPTIONS += no-async
endif

ifndef CONFIG_OLDSSL_WITH_EC2M
  OLDSSL_OPTIONS += no-ec2m
endif

ifndef CONFIG_OLDSSL_WITH_ERROR_MESSAGES
  OLDSSL_OPTIONS += no-err
endif

ifndef CONFIG_OLDSSL_WITH_TLS13
  OLDSSL_OPTIONS += no-tls1_3
endif

ifndef CONFIG_OLDSSL_WITH_ARIA
  OLDSSL_OPTIONS += no-aria
endif

ifndef CONFIG_OLDSSL_WITH_SM234
  OLDSSL_OPTIONS += no-sm2 no-sm3 no-sm4
endif

ifndef CONFIG_OLDSSL_WITH_CAMELLIA
  OLDSSL_OPTIONS += no-camellia
endif

ifndef CONFIG_OLDSSL_WITH_IDEA
  OLDSSL_OPTIONS += no-idea
endif

ifndef CONFIG_OLDSSL_WITH_SEED
  OLDSSL_OPTIONS += no-seed
endif

ifndef CONFIG_OLDSSL_WITH_MDC2
  OLDSSL_OPTIONS += no-mdc2
endif

ifndef CONFIG_OLDSSL_WITH_WHIRLPOOL
  OLDSSL_OPTIONS += no-whirlpool
endif

ifndef CONFIG_OLDSSL_WITH_CMS
  OLDSSL_OPTIONS += no-cms
endif

ifndef CONFIG_OLDSSL_WITH_RFC3779
  OLDSSL_OPTIONS += no-rfc3779
endif

ifdef CONFIG_OLDSSL_NO_DEPRECATED
  OLDSSL_OPTIONS += no-deprecated
endif

ifeq ($(CONFIG_OLDSSL_OPTIMIZE_SPEED),y)
  TARGET_CFLAGS := $(filter-out -O%,$(TARGET_CFLAGS)) -O3
else
  OLDSSL_OPTIONS += -DOLDSSL_SMALL_FOOTPRINT
endif

ifdef CONFIG_OLDSSL_ENGINE
  ifdef CONFIG_OLDSSL_ENGINE_BUILTIN
    OLDSSL_OPTIONS += disable-dynamic-engine
    ifndef CONFIG_OLDSSL_ENGINE_BUILTIN_AFALG
      OLDSSL_OPTIONS += no-afalgeng
    endif
    ifdef CONFIG_OLDSSL_ENGINE_BUILTIN_DEVCRYPTO
      OLDSSL_OPTIONS += enable-devcryptoeng
    endif
    ifndef CONFIG_OLDSSL_ENGINE_BUILTIN_PADLOCK
      OLDSSL_OPTIONS += no-hw-padlock
    endif
  else
    ifdef CONFIG_PACKAGE_liboldssl-devcrypto
      OLDSSL_OPTIONS += enable-devcryptoeng
    endif
    ifndef CONFIG_PACKAGE_liboldssl-afalg
      OLDSSL_OPTIONS += no-afalgeng
    endif
    ifndef CONFIG_PACKAGE_liboldssl-padlock
      OLDSSL_OPTIONS += no-hw-padlock
    endif
  endif
else
  OLDSSL_OPTIONS += no-engine
endif

ifndef CONFIG_OLDSSL_WITH_GOST
  OLDSSL_OPTIONS += no-gost
endif

ifndef CONFIG_OLDSSL_WITH_DTLS
  OLDSSL_OPTIONS += no-dtls
endif

ifdef CONFIG_OLDSSL_WITH_COMPRESSION
  OLDSSL_OPTIONS += zlib-dynamic
else
  OLDSSL_OPTIONS += no-comp
endif

ifndef CONFIG_OLDSSL_WITH_NPN
  OLDSSL_OPTIONS += no-nextprotoneg
endif

ifndef CONFIG_OLDSSL_WITH_PSK
  OLDSSL_OPTIONS += no-psk
endif

ifndef CONFIG_OLDSSL_WITH_SRP
  OLDSSL_OPTIONS += no-srp
endif

ifndef CONFIG_OLDSSL_WITH_ASM
  OLDSSL_OPTIONS += no-asm
endif

ifdef CONFIG_i386
  ifndef CONFIG_OLDSSL_WITH_SSE2
    OLDSSL_OPTIONS += no-sse2
  endif
endif

OLDSSL_TARGET:=linux-$(call qstrip,$(CONFIG_ARCH))-openwrt

STAMP_CONFIGURED := $(STAMP_CONFIGURED)_$(shell echo $(OLDSSL_OPTIONS) | mkhash md5)

define Build/Configure
	(cd $(PKG_BUILD_DIR); \
		./Configure $(OLDSSL_TARGET) \
			--prefix=/usr \
			--libdir=lib \
			--openssldir=/etc/oldssl \
			--cross-compile-prefix="$(TARGET_CROSS)" \
			$(TARGET_CFLAGS) \
			$(TARGET_CPPFLAGS) \
			$(TARGET_LDFLAGS) \
			$(OLDSSL_OPTIONS) && \
		{ [ -f $(STAMP_CONFIGURED) ] || make clean; } \
	)
endef

TARGET_CFLAGS += $(FPIC) -ffunction-sections -fdata-sections
TARGET_LDFLAGS += -Wl,--gc-sections

define Build/Compile
	+$(MAKE) $(PKG_JOBS) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		SOURCE_DATE_EPOCH=$(SOURCE_DATE_EPOCH) \
		OPENWRT_OPTIMIZATION_FLAGS="$(TARGET_CFLAGS)" \
		$(OLDSSL_MAKEFLAGS) \
		all
	$(MAKE) -C $(PKG_BUILD_DIR) \
		CC="$(TARGET_CC)" \
		DESTDIR="$(PKG_INSTALL_DIR)" \
		$(OLDSSL_MAKEFLAGS) \
		install_sw install_ssldirs
endef

define Build/InstallDev
	$(INSTALL_DIR) $(1)/usr/include
	$(CP) $(PKG_INSTALL_DIR)/usr/include/openssl $(1)/usr/include/oldssl
	$(INSTALL_DIR) $(1)/usr/lib/
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/lib{crypto,ssl}.so.$(ABI_VERSION) $(1)/usr/lib/
	$(INSTALL_DIR) $(1)/usr/lib/pkgconfig
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/openssl.pc $(1)/usr/lib/pkgconfig/openssl-old.pc
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libcrypto.pc $(1)/usr/lib/pkgconfig/libcrypto-old.pc
	$(CP) $(PKG_INSTALL_DIR)/usr/lib/pkgconfig/libssl.pc $(1)/usr/lib/pkgconfig/libssl-old.pc
	[ -n "$(TARGET_LDFLAGS)" ] && $(SED) 's#$(TARGET_LDFLAGS)##g' $(1)/usr/lib/pkgconfig/{openssl-old,libcrypto-old,libssl-old}.pc || true
endef

define Package/liboldssl/install
	$(INSTALL_DIR) $(1)/etc/oldssl/certs
	$(INSTALL_DIR) $(1)/etc/oldssl/private
	chmod 0700 $(1)/etc/oldssl/private
	$(INSTALL_DIR) $(1)/usr/lib
	$(INSTALL_DATA) $(PKG_INSTALL_DIR)/usr/lib/lib{crypto,ssl}.so.$(ABI_VERSION) $(1)/usr/lib/
	$(if $(CONFIG_OLDSSL_ENGINE),$(INSTALL_DIR) $(1)/usr/lib/$(ENGINES_DIR))
endef

define Package/liboldssl-conf/install
	$(INSTALL_DIR) $(1)/etc/oldssl
	$(CP) $(PKG_INSTALL_DIR)/etc/oldssl/openssl.cnf $(1)/etc/oldssl/
endef

define Package/oldssl-util/install
	$(INSTALL_DIR) $(1)/usr/bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/bin/openssl $(1)/usr/bin/oldssl
endef

define Package/liboldssl-afalg/install
	$(INSTALL_DIR) $(1)/usr/lib/$(ENGINES_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(ENGINES_DIR)/afalg.so $(1)/usr/lib/$(ENGINES_DIR)
endef

define Package/liboldssl-devcrypto/install
	$(INSTALL_DIR) $(1)/usr/lib/$(ENGINES_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(ENGINES_DIR)/devcrypto.so $(1)/usr/lib/$(ENGINES_DIR)
endef

define Package/liboldssl-padlock/install
	$(INSTALL_DIR) $(1)/usr/lib/$(ENGINES_DIR)
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/lib/$(ENGINES_DIR)/*padlock.so $(1)/usr/lib/$(ENGINES_DIR)
endef

$(eval $(call BuildPackage,liboldssl))
$(eval $(call BuildPackage,liboldssl-conf))
$(eval $(call BuildPackage,liboldssl-afalg))
$(eval $(call BuildPackage,liboldssl-devcrypto))
$(eval $(call BuildPackage,liboldssl-padlock))
$(eval $(call BuildPackage,oldssl-util))
