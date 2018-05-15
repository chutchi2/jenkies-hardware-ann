#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.archiver.stage_4
   $(call function,cpp.archiver.read_flags)
endef

#-------------------------------------------------------------------------------
define cpp.archiver.read_flags

   ifneq ($(wildcard $(CPP_AR_FLAGS_FILE)),)
      include $(CPP_AR_FLAGS_FILE)
   else ifdef cpp.archiver.flag_defs
      $$(call function,cpp.archiver.flag_defs)
   endif
      
endef
