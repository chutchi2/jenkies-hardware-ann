#-------------------------------------------------------------------------------
# Filename: makefile
#
# Description:
# Top-level makefile
#-------------------------------------------------------------------------------
PROJECT_DIR := ../../..
include $(PROJECT_DIR)/test/.makefiles/ut.common.mk

#-------------------------------------------------------------------------------
# Override ut.common.mk
#-------------------------------------------------------------------------------
#UT_NAME      := $(notdir $(patsubst %/,%,$(dir $(CURDIR))))
#PACKAGE_DIRS := ../source $(TEST_SOURCE_DIR) $(PROJECT_SOURCE_DIR)

#-------------------------------------------------------------------------------
$(call function,bluejay.assemble)
all: $(EXECUTABLES)
