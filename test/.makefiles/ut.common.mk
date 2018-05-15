#-------------------------------------------------------------------------------
# Filename: ut.common.mk
#
# Description:
# Included from all top-level unit test makefiles.
#-------------------------------------------------------------------------------
include $(PROJECT_DIR)/.makefiles/project_structure.mk
include $(PROJECT_TEST_DIR)/.makefiles/ut.project_structure.mk

BLUEJAY_COMPONENTS := \
   bluejay/standard/c/c.compiler \
   bluejay/standard/cpp/cpp.compiler \
   unit_test/ut.cpp.compiler \
   bluejay/standard/c/c.archiver \
   bluejay/standard/cpp/cpp.archiver \
   bluejay/standard/std/std.archiver \
   bluejay/standard/c/c.linker \
   bluejay/standard/cpp/cpp.linker \
   bluejay/build_tree

ifeq ($(filter-out _% flags/_%,$(wildcard *.flags.mk flags/*.flags.mk)),)
   BLUEJAY_BUILD_DIR := $(PROJECT_DIR)/test/.build
else
   BLUEJAY_BUILD_DIR := .build
endif

include $(BLUEJAY_DIR)/bluejay.mk
include $(PROJECT_MAKE_DIR)/external_package.mk
include $(TEST_MAKE_DIR)/ut.utils.mk

#-------------------------------------------------------------------------------
SEARCH_PATH := . $(TEST_MAKE_DIR)
include $(call ut.find_file,$(SEARCH_PATH),packages.mk)

#-------------------------------------------------------------------------------
UT_NAME      := $(notdir $(patsubst %/,%,$(dir $(CURDIR))))
PACKAGE_DIRS := ../source $(TEST_SOURCE_DIR) $(SOURCE_PACKAGES)
PLATFORM_DIR := $(TEST_PLATFORMS_DIR)/$(PLATFORM)

include $(PLATFORM_DIR)/platform.mk
$(call function,ut.define_flags)
