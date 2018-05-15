#-------------------------------------------------------------------------------
# Filename: ut.utils.mk
#
# Description:
# Utility functions used within test.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cle.get_kernel_name
$(shell uname -s)
endef

#-------------------------------------------------------------------------------
define ut.set_platform
   PLATFORM := $(patsubst CYGWIN_NT%,CYGWIN_NT,$(call cle.get_kernel_name))
endef

$(call function,ut.set_platform)

#-------------------------------------------------------------------------------
# Searches for file in each search path given.
#
# Search is in the order of the paths given. Returns the first file found.
#
# Arguments:
# $1 - search paths
# $2 - file
#
# Returns:
# Path to file
#-------------------------------------------------------------------------------
define ut.find_file
$(firstword $(wildcard $(addsuffix /$(2),$(1))))
endef

#-------------------------------------------------------------------------------
define ut.define_flags

   $(call local_var,search_path,. ./flags $(PLATFORM_DIR)/flags)

   C_FLAGS_FILE      := $(call ut.find_file,$(search_path),c.flags.mk)
   C_LD_FLAGS_FILE   := $(call ut.find_file,$(search_path),c.ld.flags.mk)

   CPP_FLAGS_FILE    := $(call ut.find_file,$(search_path),cpp.flags.mk)
   CPP_LD_FLAGS_FILE := $(call ut.find_file,$(search_path),cpp.ld.flags.mk)

   AR_FLAGS_FILE     := $(call ut.find_file,$(search_path),ar.flags.mk)

endef

