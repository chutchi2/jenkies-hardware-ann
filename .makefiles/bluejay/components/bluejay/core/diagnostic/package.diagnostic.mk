#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define package.diagnostic
   $(call function,print_header,$ $ $ $ $ $ $ $ $ ***** PACKAGES *****)
   $(foreach &pkg,$(PACKAGES),\
      $(eval \
         $(if $(filter $(firstword $(PACKAGES)),$(&pkg)),,$(info )) \
         $(call function,print_package_diagnostic,$(&pkg))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define print_package_diagnostic
   $(call function,print_header,Package: $(1))
   $(foreach &comp,$(BLUEJAY_COMPONENT_NAMES),\
      $(call try_function,$(&comp).package.diagnostic,$(1)))
endef
