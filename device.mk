
ifeq ($(shell test $(PLATFORM_SDK_VERSION) -le 20; echo $$?),0)
ANDROIDVERSION := /Android4.4_
else ifeq ($(shell test $(PLATFORM_SDK_VERSION) -le 25; echo $$?),0)
ANDROIDVERSION := /Android6_
else
ANDROIDVERSION := / 
endif

ifeq ($(TARGET_ARCH), arm64)
SRC_PATH := vendor/meig/meig-ril$(ANDROIDVERSION)arm64-v8a
else ifeq ($(TARGET_ARCH), arm)
SRC_PATH := vendor/meig/meig-ril$(ANDROIDVERSION)armeabi-v7a
else ifeq ($(TARGET_ARCH), x86)
$(warning "TARGET_ARCH is $(TARGET_ARCH)")
else ifeq ($(TARGET_ARCH), x86_64)
$(warning "TARGET_ARCH is $(TARGET_ARCH)")
else
$(warning "error TARGET_ARCH is null")
endif
$(warning "SRC_PATH is $(SRC_PATH)")
$(warning "PLATFORM_SDK_VERSION is $(PLATFORM_SDK_VERSION)")

ifeq ($(shell test $(PLATFORM_SDK_VERSION) -le 25; echo $$?),0)
ifeq ($(TARGET_ARCH), arm64)
TARGET_LIB_PATH := system/lib64/
else
TARGET_LIB_PATH := system/lib/
endif
else
ifeq ($(TARGET_ARCH), arm64)
TARGET_LIB_PATH := vendor/lib64/
else
TARGET_LIB_PATH := vendor/lib/
endif
endif
$(warning "TARGET_LIB_PATH is $(TARGET_LIB_PATH)")


PRODUCT_PACKAGES += \
	rild

PRODUCT_COPY_FILES += \
	$(SRC_PATH)/libmeig-ril.so:$(TARGET_LIB_PATH)/libmeig-ril.so \
	$(SRC_PATH)/chat:system/bin/chat \
	$(SRC_PATH)/ip-up:system/etc/ppp/ip-up \
	$(SRC_PATH)/ip-down:system/etc/ppp/ip-down 

PRODUCT_PROPERTY_OVERRIDES += \
	rild.libpath=/$(TARGET_LIB_PATH)/libmeig-ril.so	

