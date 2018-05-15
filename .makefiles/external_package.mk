#-------------------------------------------------------------------------------
# File: external_package.mk
#
# Description:
# An external package is a logical unit for defining third party libraries and
# include paths. This file contains functions related to external packages.
#-------------------------------------------------------------------------------
EXTERNAL_MK := external.mk
CPP_PACKAGE_LIB_DIR := lib

#-------------------------------------------------------------------------------
# Description:
# Import external.mk files in specified directories and their subdirectories.
#
# Arguments:
# $1 - list of directories to search
#
# Usage:
# $(call function,external_package.import_externals,$1)
#-------------------------------------------------------------------------------
define external_package.import_externals
   ifneq ($(strip $(1)),)
      $$(foreach &epkg,$$(call cle.find_files_ex,$(1),$(EXTERNAL_MK)),\
         $$(call function,external_package.import_external,$$(&epkg)))
   endif
endef

#-------------------------------------------------------------------------------
# Import a single external.mk file.
#
# Arguments:
# $1 - path/to/external.mk
#
# Usage:
# $(call function,external_package.import_external,$1)
#-------------------------------------------------------------------------------
define external_package.import_external

   ifneq ($(strip $(1)),)

      ifeq ($(strip $(wildcard $(1))),)
         $$(warning '$(1)': File not found)
      else

         EXTERNAL_DIR := $(call path,$(1))
         DIR_NAME    := $$(notdir $$(EXTERNAL_DIR))

         ifeq ($$(EXTERNAL_DIR),.)
            DIR_NAME := $$(notdir $$(CURDIR))
         endif

         EXTERNAL    := $$(DIR_NAME)

         include $(1)

      endif

   endif

endef

#-------------------------------------------------------------------------------
# Import an external package.
#
# Arguments:
# None
#
# Usage:
# $(call function,cpp.externals.import_external_pkg)
#-------------------------------------------------------------------------------
define cpp.import_external_pkg
   $(call local_var,inc_dir,$(EXTERNAL_DIR)/$(CPP_PACKAGE_INC_DIR))
   $(call local_var,lib_dir,$(EXTERNAL_DIR)/$(CPP_PACKAGE_LIB_DIR))
   $(call local_var,libs,$(call find_files,$(lib_dir),$(CPP_LIB_EXT)))

   $(call function,cpp.add_system_includes,$(inc_dir))
   $(call function,unsorted_list.add,CPP_LD_USER_LIBS,$(libs))
endef
