#-------------------------------------------------------------------------------
# Filename: twig.sorted_list.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Add items to the list.
#
# Items will be sorted upon insertion.
#
# Arguments:
# $1 - list name
# $2 - items to be inserted
#
# Usage:
# $(call twig.sorted_list.add,$1,$2)
#-------------------------------------------------------------------------------
define twig.sorted_list.add
$(eval 
   $(1) := $(sort $(2) $($(1)))
)
endef

#-------------------------------------------------------------------------------
# Looks for an item in the list.
#
# Arguments:
# $1 - list name
# $2 - items to be searched
#
# Returns:
# The items found.
#
# Usage:
# $(call util.sorted_list.find,$1,$2)
#-------------------------------------------------------------------------------
define twig.sorted_list.find
$(strip $(filter $(2),$($(1))))
endef
