#-------------------------------------------------------------------------------
# File: bluejay.mk
#
# Description:
# Entry point to the bluejay framework.
#
# Include this file to load the bluejay framework.
#
# * Any of the BLUEJAY_* variables defined in this file can be overriden by
#   defining them BEFORE including this file.
#
# * Variables defined in bluejay.defaults.mk can be overriden by defining them
#   AFTER including this file.
#
# Call the bluejay.assemble function after all variables have been defined.
#
# * After calling bluejay.assemble, define the 'all' target.
#   all: $(EXECUTABLES)
#
# Example makefile:
#
# BLUEJAY_BUILD_DIR := _mybuild_
#
# include bluejay/bluejay.mk
#
# PACKAGE_DIRS   := ../source
# C_FLAGS_FILE   := flags/c.flags.mk
# CPP_FLAGS_FILE := flags/cpp.flags.mk
# AR_FLAGS_FILE  := flags/ar.flags.mk
# LD_FLAGS_FILE  := flags/ld.flags.mk
#
# EXE_EXT := exe
# 
# $(call function,bluejay.assemble)
# all: $(EXECUTABLES)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Bluejay Core Definitions
#-------------------------------------------------------------------------------
# Override these definitions by defining them BEFORE including this file.

ifndef BLUEJAY_HOME_DIR
   BLUEJAY_HOME_DIR := $(patsubst %/,%,$(dir $(lastword $(MAKEFILE_LIST))))
endif

ifndef BLUEJAY_BUILD_DIR
   BLUEJAY_BUILD_DIR := ./_build_
endif

ifndef BLUEJAY_DEFAULT_GOAL
   BLUEJAY_DEFAULT_GOAL := all
endif

ifndef BLUEJAY_DEFAULTS_DIR
   BLUEJAY_DEFAULTS_DIR := defaults
endif

ifndef BLUEJAY_COMPONENT_DIR
   BLUEJAY_COMPONENT_DIR := components
endif

ifndef BLUEJAY_TOOLCHAIN_DIR
   BLUEJAY_TOOLCHAIN_DIR := toolchains
endif

ifndef BLUEJAY_DEFAULTS
   BLUEJAY_DEFAULTS := \
      bluejay/defaults
endif

ifndef BLUEJAY_COMPONENTS
   BLUEJAY_COMPONENTS := \
      bluejay/standard/c/c.compiler \
      bluejay/standard/cpp/cpp.compiler \
      bluejay/standard/c/c.archiver \
      bluejay/standard/cpp/cpp.archiver \
      bluejay/standard/std/std.archiver \
      bluejay/standard/c/c.linker \
      bluejay/standard/cpp/cpp.linker \
      bluejay/build_tree
endif

ifndef BLUEJAY_TOOLCHAINS
   BLUEJAY_TOOLCHAINS := \
      bluejay/gnu
endif

#-------------------------------------------------------------------------------
# Return a list of component names derived from BLUEJAY_COMPONENTS.
#
# Usage:
# $(BLUEJAY_COMPONENT_NAMES)
#-------------------------------------------------------------------------------
define BLUEJAY_COMPONENT_NAMES
$(foreach &comp,$(BLUEJAY_COMPONENTS),$(notdir $(&comp)))
endef

#-------------------------------------------------------------------------------
# Bootstrap the bluejay framework
include $(BLUEJAY_HOME_DIR)/bluejay.bootstrap.mk

#-------------------------------------------------------------------------------
# Assemble rules and other constructs needed by make to build.
#
# Arguments:
# None
#
# Usage:
# $(call function,bluejay.assemble)
#-------------------------------------------------------------------------------
define bluejay.assemble

   ifeq ($(strip $(PACKAGE_DIRS)),)
      $$(warning PACKAGE_DIRS is empty or not defined.)
   endif

   $(call function,package.import_packages,$(PACKAGE_DIRS))

   $(foreach &stage,3 4 5 6,\
      $(foreach &comp,$(BLUEJAY_COMPONENT_NAMES),\
         $(call try_function,$(&comp).stage_$(&stage))))

   $(call function,diagnostic.print)

endef
