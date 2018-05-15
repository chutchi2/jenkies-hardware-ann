#-------------------------------------------------------------------------------
# File: utils.sorted_list.mk
#
# Description:
# Utility functions used throughout the bluejay framework.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - accessor name
# $3 - list name
#-------------------------------------------------------------------------------
define declare_sorted_list

$(call local_var,pkg,$(1))
$(call local_var,accessor_name,$(2))
$(call local_var,list_name,$(3))

define $(pkg).add_$(accessor_name)
   $$(call function,sorted_list.add,$(list_name),$$(1))
endef

define $(pkg).get_$(accessor_name)
$$(call sorted_list.get,$(list_name))
endef

define $(pkg).has_$(accessor_name)
$$(call sorted_list.find,$(list_name),$$(1))
endef

endef

#-------------------------------------------------------------------------------
# Developer Notes:
# If $(1) is the same name as a local_var, the variable that is set to the value
# $(2) will be undefined when the function goes out of scope. This applies to
# any function that sets a variable based on an argument. Should probably use
# _var_name as a convention for local variables that may conflict with variable
# names given as arguments.
#
# Arguments:
# $1 - list name
# $2 - value
#
# Usage:
# $(call function,sorted_list.add,$1,$2)
#-------------------------------------------------------------------------------
define sorted_list.add

   $(call local_var,list_name,$(1))

   ifeq ($(list_name),)
      $$(warning List name is empty.)
   else
      $(list_name) := $(sort $($(list_name)) $(2))
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list name
#
# Usage:
# $(call function,sorted_list.get,$1)
#-------------------------------------------------------------------------------
define sorted_list.get
$(strip \
   $(if $(1),\
      $($(strip $(1))),\
      $(warning List name is empty.)))
endef

#-------------------------------------------------------------------------------
# Looks for items in a list.
#
# Arguments:
# $1 - list name
# $2 - items to look for in the list
#
# Returns:
# The items found.
#
# Usage:
# $(call sorted_list.find,$1,$2)
#-------------------------------------------------------------------------------
define sorted_list.find
$(strip $(filter $(2),$(call sorted_list.get,$(1))))
endef
