#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.linker.stage_4
   $(call function,cpp.linker.read_flags)
endef

#-------------------------------------------------------------------------------
define cpp.linker.read_flags

   ifneq ($(wildcard $(CPP_LD_FLAGS_FILE)),)
      include $(CPP_LD_FLAGS_FILE)
   else ifdef cpp.linker.flag_defs
      $$(call function,cpp.linker.flag_defs)
   endif
      
endef
