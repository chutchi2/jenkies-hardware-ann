#-------------------------------------------------------------------------------
# Filename: test.cpp.import.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk
BLUEJAY_COMPONENTS := bluejay/standard/cpp/cpp.compiler
include ../../../bluejay.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------
SOURCE_DIR := ../source

EMPTY_DIR  := $(SOURCE_DIR)/empty

A_DIR   := $(SOURCE_DIR)/a
A_FILES := \
   $(A_DIR)/a.cpp \
   $(A_DIR)/b.cpp

B_DIR   := $(SOURCE_DIR)/b
B_FILES := \
   $(B_DIR)/b.cpp \
   $(B_DIR)/c/c.cpp \
   $(B_DIR)/c/d/d.cc \
   $(B_DIR)/c/d/e/e.cpp

C_PKG_DIR       := $(SOURCE_DIR)/c.pkg

C_PKG_FILES := \
   $(C_PKG_DIR)/src/apple.cpp \
   $(C_PKG_DIR)/src/banana.cc \

C_PKG_PUBLIC_INCLUDES := \
   $(C_PKG_DIR)/inc

C_PKG_PRIVATE_INCLUDES := \
   $(C_PKG_DIR)/src

D_DIR   := $(SOURCE_DIR)/d

define clear_package
   $(call twig.undefine,CPP_PACKAGES)
   $(call twig.undefine,$(PACKAGE)_CPP_SOURCE_DIRS)
   $(call twig.undefine,$(PACKAGE)_CPP_PUBLIC_INCLUDES)
   $(call twig.undefine,$(PACKAGE)_CPP_SOURCE_FILES)

   $(call twig.undefine,PACKAGE_DIR)
   $(call twig.undefine,PACKAGE)
endef

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.import_package)

PACKAGE     := c
PACKAGE_DIR := $(C_PKG_DIR)

$(call function,cpp.import_package)
$(call ut.assert_equal,$(PACKAGE),$(CPP_PACKAGES))
$(call ut.assert_equal,$(C_PKG_DIR)/src,$($(PACKAGE)_CPP_SOURCE_DIRS))
$(call ut.assert_equal,$(C_PKG_PUBLIC_INCLUDES),$($(PACKAGE)_CPP_PUBLIC_INCLUDES))
$(call ut.assert_equal,$(C_PKG_FILES),$($(PACKAGE)_CPP_SOURCE_FILES))

$(call function,clear_package)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.import_dir)

PACKAGE     := a
PACKAGE_DIR := $(A_DIR)

$(call function,cpp.import_dir)
$(call ut.assert_equal,$(PACKAGE),$(CPP_PACKAGES))
$(call ut.assert_equal,$(A_DIR),$($(PACKAGE)_CPP_SOURCE_DIRS))
$(call ut.assert_equal,$(A_DIR),$($(PACKAGE)_CPP_PUBLIC_INCLUDES))
$(call ut.assert_equal,$(A_FILES),$($(PACKAGE)_CPP_SOURCE_FILES))

$(call function,clear_package)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.import_dirs)

PACKAGE     := d
PACKAGE_DIR := $(D_DIR)

$(call function,cpp.import_dirs,b1/c1)
$(call ut.assert_equal,$(PACKAGE),$(CPP_PACKAGES))
$(call ut.assert_equal,$(D_DIR),$($(PACKAGE)_CPP_SOURCE_DIRS))
$(call ut.assert_equal,$(D_DIR)/b1/c1,$($(PACKAGE)_CPP_PUBLIC_INCLUDES))
$(call ut.assert_equal,$(D_DIR)/b1/c1/c1.cc,$($(PACKAGE)_CPP_SOURCE_FILES))

$(call function,cpp.import_dirs,b3)
$(call ut.assert_equal,$(PACKAGE),$(CPP_PACKAGES))
$(call ut.assert_equal,$(D_DIR),$($(PACKAGE)_CPP_SOURCE_DIRS))
$(call ut.assert_equal,$(sort $(D_DIR)/b1/c1 $(D_DIR)/b3),$($(PACKAGE)_CPP_PUBLIC_INCLUDES))
$(call ut.assert_equal,$(sort $(D_DIR)/b1/c1/c1.cc $(D_DIR)/b3/b3.cpp),$($(PACKAGE)_CPP_SOURCE_FILES))

$(call function,clear_package)
