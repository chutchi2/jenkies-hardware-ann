#-------------------------------------------------------------------------------
# Filename: twig.undefine.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Undefine a list of variables.
#
# Arguments:
# $1 - list of variable names
#
# Usage:
# $(call twig.undefine,$1)
#-------------------------------------------------------------------------------
define twig.undefine
$(eval 
   ifeq ($(call twig.isVersion,3.82),)
      $$(foreach var,$(1),$$(eval $$(var) :=))
   else
      $$(foreach var,$(1),$$(eval undefine $$(var)))
   endif
)
endef
