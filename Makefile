include theos/makefiles/common.mk

#BUNDLE_NAME = 0
#0_FILES = ms.c
#0_INSTALL_PATH = /Applications/Lowtide.app/Appliances
#0_BUNDLE_EXTENSION = frappliance

TWEAK_NAME = beigelist
beigelist_FILES = vip.mm

#include $(FW_MAKEDIR)/bundle.mk
include $(FW_MAKEDIR)/tweak.mk

after-install::
	install.exec "killall -9 Lowtide"
