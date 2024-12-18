export TARGET_CODESIGN_FLAGS="-Ssign.plist"
THEOS_PACKAGE_SCHEME=rootless
export TARGET=iphone:clang:latest:7.0
GO_EASY_ON_ME=1
include $(THEOS)/makefiles/common.mk

TOOL_NAME = ipainstaller
ipainstaller_FILES = \
					ZipArchive/minizip/ioapi.c \
					ZipArchive/minizip/mztools.c \
					ZipArchive/minizip/unzip.c \
					ZipArchive/minizip/zip.c \
					ZipArchive/ZipArchive.mm \
					UIDevice-Capabilities/UIDevice-Capabilities.m \
					main.mm
ipainstaller_FRAMEWORKS = Foundation UIKit ImageIO CoreGraphics
ipainstaller_PRIVATE_FRAMEWORKS = GraphicsServices MobileCoreServices
ipainstaller_LDFLAGS = -lz -F/var/jb/Library/Frameworks -lMobileInstallation
ipainstaller_INSTALL_PATH = /var/jb/usr/bin

include $(THEOS_MAKE_PATH)/tool.mk

VERSION.INC_BUILD_NUMBER = 1

before-package::
	ln -s ipainstaller $(THEOS_STAGING_DIR)/var/jb/usr/bin/installipa
	find $(THEOS_STAGING_DIR) -exec touch -r $(THEOS_STAGING_DIR)/var/jb/usr/bin/installipa {} \;
	chmod 0755 $(THEOS_STAGING_DIR)/var/jb/usr/bin/ipainstaller
	chmod 0644 $(THEOS_STAGING_DIR)/DEBIAN/control


