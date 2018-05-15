#-------------------------------------------------------------------------------
# File: utils.unsorted_pkg_list.mk
#
# Description:
# Utility functions used throughout the bluejay framework.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - accessor name
# $3 - list name
# $4 - name of variable containing list of packages
#-------------------------------------------------------------------------------
define declare_unsorted_pkg_list

   $(call local_var,pkg,$(1))
   $(call local_var,accessor_name,$(2))
   $(call local_var,list_name,$(3))
   $(call local_var,packages,$(4))
   
   define $(pkg).add_$(accessor_name)
      $$(call function,unsorted_pkg_list.add,$$(1),$(list_name),$$(2))
   endef
   
   define $(pkg).get_$(accessor_name)
      $$(call unsorted_pkg_list.get,$$(1),$(list_name))
   endef
   
   define $(pkg).get_all_$(accessor_name)
      $$(call unsorted_pkg_list.get_all,$$(if $$(1),$$(1),$(packages)),$(list_name))
   endef
   
   define $(pkg).has_$(accessor_name)
      $$(call unsorted_pkg_list.find,$$(1),$(list_name),$$(2))
   endef

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - list name
# $3 - value
#
# Usage:
# $(call function,unsorted_pkg_list.add,$1,$2,$3)
#-------------------------------------------------------------------------------
define unsorted_pkg_list.add

   $(call local_var,pkg,$(1))
   $(call local_var,list_name,$(2))
   $(call local_var,list,$(pkg)_$(list_name))

   ifeq ($(pkg),)
      $$(warning Package name is empty.)
   else ifeq ($(list_name),)
      $$(warning List name is empty.)
   else
      $(list) := $(strip $($(list)) $(3))
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - list name
#
# Usage:
# $(call function,unsorted_pkg_list.get,$1,$2)
#-------------------------------------------------------------------------------
define unsorted_pkg_list.get
$(strip \
   $(if $(1),\
      $(if $(2),\
         $($(strip $(1))_$(strip $(2))),\
         $(warning List name is empty.)),\
      $(warning Package name is empty.)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list of packages
# $2 - list name
#
# Usage:
# $(call unsorted_pkg_list.get_all,$1)
#
# Returns:
# Values of package variables from each package in the package list
#-------------------------------------------------------------------------------
define unsorted_pkg_list.get_all
$(strip \
   $(if $(1),\
      $(if $(2),\
         $(call compound_expand,$(strip $(1)),_$(strip $(2))),\
         $(warning List name is empty.)),\
      $(warning Package list name is empty.)))
endef

#-------------------------------------------------------------------------------
# Looks for items in a list.
#
# Arguments:
# $1 - package
# $2 - list name
# $3 - items to look for in the list
#
# Returns:
# The items found.
#
# Usage:
# $(call unsorted_pkg_list.find,$1,$2,$3)
#-------------------------------------------------------------------------------
define unsorted_pkg_list.find
$(strip $(filter $(3),$(call unsorted_pkg_list.get,$(1),$(2))))
endef
