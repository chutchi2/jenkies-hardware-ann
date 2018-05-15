#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define std.archiver.stage_4
   $(call function,std.archiver.read_flags)
endef

#-------------------------------------------------------------------------------
define std.archiver.read_flags

   ifneq ($(wildcard $(AR_FLAGS_FILE)),)
      include $(AR_FLAGS_FILE)
   else ifdef std.archiver.flag_defs
      $$(call function,std.archiver.flag_defs)
   endif
      
endef
