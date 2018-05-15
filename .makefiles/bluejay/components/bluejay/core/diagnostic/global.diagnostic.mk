#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define global.diagnostic
   $(call function,print_header,Global Environment)
   $(info MAKEFLAGS              : $(MAKEFLAGS))
   $(info .DEFAULT_GOAL          : $(.DEFAULT_GOAL))
   $(info )
   $(info BLUEJAY_HOME_DIR       : $(BLUEJAY_HOME_DIR))
   $(info BLUEJAY_BUILD_DIR      : $(BLUEJAY_BUILD_DIR))
   $(info BLUEJAY_DEFAULT_GOAL   : $(BLUEJAY_DEFAULT_GOAL))
   $(info BLUEJAY_COMPONENT_DIR  : $(BLUEJAY_COMPONENT_DIR))
   $(info BLUEJAY_TOOLCHAIN_DIR  : $(BLUEJAY_TOOLCHAIN_DIR))

   $(call local_var,list,\
      BLUEJAY_COMPONENTS \
      BLUEJAY_COMPONENT_NAMES \
      BLUEJAY_TOOLCHAINS \
      MAKEFILE_LIST)

   $(call function,print_lists,$(list))
endef
