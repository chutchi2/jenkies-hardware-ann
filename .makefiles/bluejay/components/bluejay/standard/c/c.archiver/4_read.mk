#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.archiver.stage_4
   $(call function,c.archiver.read_flags)
endef

#-------------------------------------------------------------------------------
define c.archiver.read_flags

   ifneq ($(wildcard $(C_AR_FLAGS_FILE)),)
      include $(C_AR_FLAGS_FILE)
   else ifdef c.archiver.flag_defs
      $$(call function,c.archiver.flag_defs)
   endif
      
endef
