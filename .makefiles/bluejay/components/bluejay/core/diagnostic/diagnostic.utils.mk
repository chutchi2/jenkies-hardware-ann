#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Define a SPACE and $( )
SPACE :=
SPACE +=
$(SPACE) :=
$(SPACE) +=

#-------------------------------------------------------------------------------
# Arguments:
# $1 - string
#-------------------------------------------------------------------------------
define print_header
   $(info ========================================)
   $(info $(SPACE)$(1))
   $(info ========================================)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - component
#-------------------------------------------------------------------------------
define print_component_header
   $(call function,print_header,Component: $(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - string
#-------------------------------------------------------------------------------
define print_subheader
   $(info ----------------------------------------)
   $(info $(SPACE)$(1))
   $(info ----------------------------------------)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - component
#-------------------------------------------------------------------------------
define print_component_subheader
   $(info )
   $(call function,print_subheader,Component: $(1))
endef

#-------------------------------------------------------------------------------
# Print multiple variables as lists.
#
# Each variable name will be printed in a header at the beginning of each list.
#
# Arguments:
# $1 - a list of variable names to be printed as lists
#
# Usage:
# $(call function,print_lists,$1)
#-------------------------------------------------------------------------------
define print_lists
   $(foreach &list,$(1),$(eval $(call print_list,$(&list))))
endef

#-------------------------------------------------------------------------------
# Print each item in a variable as a list.
#
# The variable name will be printed in a header at the beginning of the list.
#
# Arguments:
# $1 - variable name
#
# Usage:
# $(call function,print_list,$1)
#-------------------------------------------------------------------------------
define print_list
   $(info )
   $(info ===== $(1))
   $(foreach &item,$($1),$(info $(&item)))
endef

#-------------------------------------------------------------------------------
# Print each item in a variable as a list.
#
# The list will only be printed if the variable is not empty.
# The variable name will be printed in a header at the beginning of the list.
#
# Arguments:
# $1 - variable name
#
# Usage:
# $(call function,print_list_if_not_empty,$1)
#-------------------------------------------------------------------------------
define print_list_if_not_empty
   $(if $($(1)),$(eval $(call print_list,$(1))))
endef

#-------------------------------------------------------------------------------
# Print the name and value of multiple variables.
#
# Arguments:
# $1 - variable names
#
# Usage:
# $(call function,print_vars,$1)
#-------------------------------------------------------------------------------
define print_vars
   $(foreach &var,$(1),$(eval $(call print_var,$(&var))))
endef

#-------------------------------------------------------------------------------
# Print the name and value of a variable.
#
# Arguments:
# $1 - variable name
#
# Usage:
# $(call function,print_var,$1)
#-------------------------------------------------------------------------------
define print_var
   ifdef $(1)
      $$(info $(1) = [$($(1))])
   else
      $$(info $(1) = [undefined])
   endif
endef
