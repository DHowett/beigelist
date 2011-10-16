include theos/makefiles/common.mk

TWEAK_NAME = beigelist 0bacon
beigelist_FILES = vip2.xm
beigelist_LDFLAGS = -weak_library $(THEOS_OBJ_DIR)/BackRow.stub.dylib
beigelist_LDFLAGS += -weak_library $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
beigelist_LDFLAGS += -undefined dynamic_lookup

0bacon_FILES = bacon.xm
0bacon_LDFLAGS = -weak_library $(THEOS_OBJ_DIR)/BackRow.stub.dylib
0bacon_LDFLAGS += -weak_library $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
0bacon_LDFLAGS += -undefined dynamic_lookup

include $(THEOS_MAKE_PATH)/tweak.mk

$(THEOS_OBJ_DIR)/%.stub.dylib: override THEOS_CURRENT_INSTANCE = $*
$(THEOS_OBJ_DIR)/%.stub.dylib: override _THEOS_CURRENT_TYPE = stub
$(THEOS_OBJ_DIR)/%.stub.dylib: _STUB_PATH = /System/Library/PrivateFrameworks/$*.framework/$*
$(THEOS_OBJ_DIR)/%.stub.dylib:
	$(ECHO_LINKING)echo "" | $(TARGET_LD) $(TARGET_LDFLAGS) -dynamiclib -install_name $(_STUB_PATH) -o $@ -x c -; $(TARGET_STRIP) -c $@$(ECHO_END)

$(THEOS_OBJ_DIR)/beigelist.dylib: $(THEOS_OBJ_DIR)/BackRow.stub.dylib $(THEOS_OBJ_DIR)/AppleTV.stub.dylib
$(THEOS_OBJ_DIR)/0bacon.dylib: $(THEOS_OBJ_DIR)/BackRow.stub.dylib $(THEOS_OBJ_DIR)/AppleTV.stub.dylib

after-stage::
	mkdir -p $(THEOS_STAGING_DIR)/Library/Appliances
