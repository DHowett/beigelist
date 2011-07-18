include theos/makefiles/common.mk

TWEAK_NAME = beigelist
beigelist_FILES = vip2.xm
beigelist_LDFLAGS = -weak_library $(THEOS_OBJ_DIR)/BackRow.stub -weak_library $(THEOS_OBJ_DIR)/AppleTV.stub -undefined dynamic_lookup

include $(FW_MAKEDIR)/tweak.mk

$(THEOS_OBJ_DIR)/BackRow.stub: override THEOS_CURRENT_INSTANCE = BackRowStub
$(THEOS_OBJ_DIR)/BackRow.stub: stub.c
	$(ECHO_COMPILING)$(TARGET_LD) $(TARGET_LDFLAGS) -dynamiclib -install_name /System/Library/PrivateFrameworks/BackRow.framework/BackRow -o $@ $<$(ECHO_END)
	$(ECHO_STRIPPING)$(TARGET_STRIP) -xc $@$(ECHO_END)

$(THEOS_OBJ_DIR)/AppleTV.stub: override THEOS_CURRENT_INSTANCE = AppleTVStub
$(THEOS_OBJ_DIR)/AppleTV.stub: stub.c
	$(ECHO_COMPILING)$(TARGET_LD) $(TARGET_LDFLAGS) -dynamiclib -install_name /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV -o $@ $<$(ECHO_END)
	$(ECHO_STRIPPING)$(TARGET_STRIP) -xc $@$(ECHO_END)

$(THEOS_OBJ_DIR)/beigelist.dylib: $(THEOS_OBJ_DIR)/BackRow.stub $(THEOS_OBJ_DIR)/AppleTV.stub

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/Appliances

before-package::
	cp extrainst_ $(THEOS_STAGING_DIR)/DEBIAN/extrainst_
