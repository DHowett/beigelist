GO_EASY_ON_ME=1
export THEOS_DEVICE_IP=apple-tv.local
#export THEOS_DEVICE_IP=testtv.local
include theos/makefiles/common.mk

TWEAK_NAME = beigelist beigelist5 beigelist6 0bacon
beigelist_FILES = vip2.xm 
beigelist_LDFLAGS = -weak_library $(THEOS_OBJ_DIR)/BackRow.stub.dylib
beigelist_LDFLAGS += -weak_library $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
beigelist_LDFLAGS += -undefined dynamic_lookup

beigelist5_FILES = vip5.xm Classes/BLAppLegacyCategoryController.m Classes/BLAppLegacyMerchant.m Classes/BLAppManager.m Classes/BLApplianceController.m
beigelist5_FILES += Classes/BLAppMerchantInfo.m
beigelist5_LDFLAGS = -weak_library $(THEOS_OBJ_DIR)/BackRow.stub.dylib
beigelist5_LDFLAGS += -weak_library $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
beigelist5_LDFLAGS += -undefined dynamic_lookup

beigelist6_FILES =  vip6.xm Classes6/BLAppLegacyCategoryController.xm Classes6/BLApplianceController.xm
beigelist6_FILES += Classes6/BLAppMerchantInfo.xm Classes6/BLAppLegacyMerchant.m Classes6/BLAppManager.m 
beigelist6_LDFLAGS = -undefined dynamic_lookup

0bacon_FILES = bacon.xm
0bacon_LDFLAGS = -weak_library $(THEOS_OBJ_DIR)/BackRow.stub.dylib
0bacon_LDFLAGS += -weak_library $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
0bacon_LDFLAGS += -undefined dynamic_lookup

ADDITIONAL_CFLAGS = -DVERSION="\"$(THEOS_PACKAGE_BASE_VERSION)\""

include $(THEOS_MAKE_PATH)/tweak.mk

$(THEOS_OBJ_DIR)/%.stub.dylib: override THEOS_CURRENT_INSTANCE = $*
$(THEOS_OBJ_DIR)/%.stub.dylib: override _THEOS_CURRENT_TYPE = stub
$(THEOS_OBJ_DIR)/%.stub.dylib: _STUB_PATH = /System/Library/PrivateFrameworks/$*.framework/$*
$(THEOS_OBJ_DIR)/%.stub.dylib:
	$(ECHO_LINKING)echo "" | $(TARGET_LD) $(TARGET_LDFLAGS) -dynamiclib -install_name $(_STUB_PATH) -o $@ -x c -; $(TARGET_STRIP) -c $@$(ECHO_END)

$(THEOS_OBJ_DIR)/beigelist.dylib: $(THEOS_OBJ_DIR)/BackRow.stub.dylib $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
$(THEOS_OBJ_DIR)/beigelist5.dylib: $(THEOS_OBJ_DIR)/BackRow.stub.dylib $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
$(THEOS_OBJ_DIR)/0bacon.dylib: $(THEOS_OBJ_DIR)/BackRow.stub.dylib $(THEOS_OBJ_DIR)/AppleTV.stub.dylib

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/Appliances

after-install::
	install.exec "killall -9 AppleTV"
