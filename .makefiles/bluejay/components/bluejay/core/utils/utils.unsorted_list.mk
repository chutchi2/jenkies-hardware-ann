#-------------------------------------------------------------------------------
# File: utils.unsorted_list.mk
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
define declare_unsorted_list

$(call local_var,pkg,$(1))
$(call local_var,accessor_name,$(2))
$(call local_var,list_name,$(3))

define $(pkg).add_$(accessor_name)
   $$(call function,unsorted_list.add,$(list_name),$$(1))
endef

define $(pkg).get_$(accessor_name)
$$(call unsorted_list.get,$(list_name))
endef

define $(pkg).has_$(accessor_name)
$$(call unsorted_list.find,$(list_name),$$(1))
endef

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list name
# $2 - value
#
# Usage:
# $(call function,unsorted_list.add,$1,$2)
#-------------------------------------------------------------------------------
define unsorted_list.add

   $(call local_var,list_name,$(1))

   ifeq ($(list_name),)
      $$(warning List name is empty.)
   else
      $(list_name) := $(strip $($(list_name)) $(2))
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list name
#
# Usage:
# $(call function,unsorted_list.get,$1)
#-------------------------------------------------------------------------------
define unsorted_list.get
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
# $(call unsorted_list.find,$1,$2)
#-------------------------------------------------------------------------------
define unsorted_list.find
$(strip $(filter $(2),$(call unsorted_list.get,$(1))))
endef
