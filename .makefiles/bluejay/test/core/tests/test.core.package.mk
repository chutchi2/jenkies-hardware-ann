#-------------------------------------------------------------------------------
# Filename: test.core.package.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk
BLUEJAY_COMPONENTS := bluejay/null
include ../../../bluejay.mk

all: ; @:

#-------------------------------------------------------------------------------
# Test Variables
#-------------------------------------------------------------------------------
SOURCE_DIR := ../source

EMPTY_DIR  := $(SOURCE_DIR)/empty

TEST_PKG_NAME := overflow
TEST_PKG_FILE := $(SOURCE_DIR)/test.$(PACKAGE_EXT)/$(PACKAGE_MK)

RIVER_PKG_NAME := river
RIVER_PKG_FILE := $(SOURCE_DIR)/$(RIVER_PKG_NAME).$(PACKAGE_EXT)/.bluejay

LOCAL_PKG_NAME := tests
LOCAL_PKG_FILE := $(PACKAGE_MK)

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,package.add_package)

# No package.mk
$(call function,package.add_package,)
$(call ut.assert_empty,$(PACKAGES))

# EMPTY_DIR
$(call function,package.add_package,$(EMPTY_DIR)/$(PACKAGE_MK))
$(call ut.assert_empty,$(PACKAGES))

# test.pkg
$(call function,package.add_package,$(TEST_PKG_FILE))
$(call ut.assert_equal,$(TEST_PKG_NAME),$(PACKAGES))

# river.pkg
$(call function,package.add_package,$(RIVER_PKG_FILE))
$(call ut.assert_equal,$(sort $(TEST_PKG_NAME) $(RIVER_PKG_NAME)),$(PACKAGES))

# package.mk
$(call function,package.add_package,$(LOCAL_PKG_FILE))
$(call ut.assert_equal,\
   $(sort $(TEST_PKG_NAME) $(RIVER_PKG_NAME) $(LOCAL_PKG_NAME)),\
   $(PACKAGES))

$(call twig.undefine,PACKAGES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,package.import_packages)

# No list
$(call function,package.import_packages,)
$(call ut.assert_empty,$(PACKAGES))

# SOURCE_DIR
$(call function,package.import_packages,$(SOURCE_DIR))
$(call ut.assert_equal,$(TEST_PKG_NAME),$(PACKAGES))
$(call twig.undefine,PACKAGES)

# SOURCE_DIR .
$(call function,package.import_packages,$(SOURCE_DIR) .)
$(call ut.assert_equal,$(sort $(TEST_PKG_NAME) $(LOCAL_PKG_NAME)),$(PACKAGES))
$(call twig.undefine,PACKAGES)
