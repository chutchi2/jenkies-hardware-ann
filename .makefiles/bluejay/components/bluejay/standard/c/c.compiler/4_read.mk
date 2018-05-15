#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.compiler.stage_4
   $(call function,c.read_flags)
endef

#-------------------------------------------------------------------------------
define c.read_flags

   ifneq ($(wildcard $(C_FLAGS_FILE)),)
      include $(C_FLAGS_FILE)
   else ifdef c.flag_defs
      $$(call function,c.flag_defs)
   else
      $$(error No c flags found)
   endif
      
endef
