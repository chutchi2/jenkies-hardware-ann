#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.linker.stage_4
   $(call function,c.linker.read_flags)
endef

#-------------------------------------------------------------------------------
define c.linker.read_flags

   ifneq ($(wildcard $(C_LD_FLAGS_FILE)),)
      include $(C_LD_FLAGS_FILE)
   else ifdef c.linker.flag_defs
      $$(call function,c.linker.flag_defs)
   endif
      
endef
