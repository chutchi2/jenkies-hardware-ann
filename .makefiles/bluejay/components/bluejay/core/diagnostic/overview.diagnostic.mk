#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define overview.diagnostic
   $(call function,print_header,Overview)

   $(call local_var,list,\
      PACKAGES \
      PROGRAMS \
      STATIC_LIBS \
      SECONDARY_STATIC_LIBS \
      EXECUTABLES \
      BUILD_DIRS \
      CLEAN_DIRS)

   $(call function,print_lists,$(list))
endef
