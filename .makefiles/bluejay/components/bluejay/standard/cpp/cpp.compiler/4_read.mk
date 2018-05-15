#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.compiler.stage_4
   $(call function,cpp.read_flags)
endef

#-------------------------------------------------------------------------------
define cpp.read_flags

   ifneq ($(wildcard $(CPP_FLAGS_FILE)),)
      include $(CPP_FLAGS_FILE)
   else ifdef cpp.flag_defs
      $$(call function,cpp.flag_defs)
   else
      $$(error No cpp flags found)
   endif
      
endef
