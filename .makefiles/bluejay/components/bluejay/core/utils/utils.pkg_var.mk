#-------------------------------------------------------------------------------
# File: utils.pkg_var.mk
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
define declare_pkg_var

   $(call local_var,pkg,$(1))
   $(call local_var,accessor_name,$(2))
   $(call local_var,list_name,$(3))
   $(call local_var,packages,$(4))

   define $(pkg).set_$(accessor_name)
      $$(call function,pkg_var.set,$$(1),$(list_name),$$(2))
   endef

   define $(pkg).get_$(accessor_name)
      $$(call pkg_var.get,$$(1),$(list_name))
   endef

   define $(pkg).get_all_$(accessor_name)
      $$(call pkg_var.get_all,$$(if $$(1),$$(1),$(packages)),$(list_name))
   endef

endef

#-------------------------------------------------------------------------------
# Developer Notes:
# Assigning a function argument, like $(1), to a variable eliminates leading
# spaces on assignment.
#
# Arguments:
# $1 - package
# $2 - var name
# $3 - value
#
# Usage:
# $(call function,pkg_var.set,$1,$2,$3)
#-------------------------------------------------------------------------------
define pkg_var.set
   
   $(call local_var,pkg,$(1))
   $(call local_var,var_name,$(2))
   $(call local_var,var,$(pkg)_$(var_name))

   ifeq ($(pkg),)
      $$(warning Package name is empty.)
   else ifeq ($(var_name),)
      $$(warning Variable name is empty.)
   else
      $(var) := $(3)
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - var name
#
# Usage:
# $(call pkg_var.get,$1,$2)
#
# Returns:
# Value of package variable
#-------------------------------------------------------------------------------
define pkg_var.get
$(strip \
   $(if $(1),\
      $(if $(2),\
         $($(strip $(1))_$(strip $(2))),\
         $(warning Variable name is empty.)),\
      $(warning Package name is empty.)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list of packages
# $2 - var name
#
# Usage:
# $(call pkg_var.get_all,$1,$2)
#
# Returns:
# Values of package variables from each package in the package list
#-------------------------------------------------------------------------------
define pkg_var.get_all
$(strip \
   $(if $(1),\
      $(if $(2),\
         $(call compound_expand,$(strip $(1)),_$(strip $(2))),\
         $(warning Variable name is empty.)),\
      $(warning Package list name is empty.)))
endef
