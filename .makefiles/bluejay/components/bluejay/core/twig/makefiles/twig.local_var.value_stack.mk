#-------------------------------------------------------------------------------
# Filename: twig.local_var.value_stack.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Return the name of the stack used by a specific variable name.
#
# Arguments:
# $1 - variable name
#
# Returns:
# The name of the stack used by $1.
#
# Usage:
# $(call twig.local_var.value_stack.get_stack_name,$1)
#-------------------------------------------------------------------------------
__get_stack_name__ = $(call twig.local_var.value_stack.get_stack_name,$(1))

define twig.local_var.value_stack.get_stack_name
__$(1)_values__
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
#
# Returns:
#
# Usage:
# $(call twig.local_var.value_stack.get_holder_name,$1)
#-------------------------------------------------------------------------------
__get_stack_size__  = $(call twig.stack.size,$(__get_stack_name__))
__get_holder_name__ = $(call twig.local_var.value_stack.get_holder_name,$(1))

define twig.local_var.value_stack.get_holder_name
__$(1)[$(__get_stack_size__)]_value__
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
#
# Returns:
#
# Usage:
# $(call twig.local_var.value_stack.get_new_holder_name,$1)
#-------------------------------------------------------------------------------
__get_next_stack_size__ = $(call twig.stack.next_size,$(__get_stack_name__))
__get_new_holder_name__ = $(call twig.local_var.value_stack.get_new_holder_name,$(1))

define twig.local_var.value_stack.get_new_holder_name
__$(1)[$(__get_next_stack_size__)]_value__
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
# $2 - value (optional)
#
# Usage:
# $(call twig.local_var.value_stack.push_value,$1,$2)
#-------------------------------------------------------------------------------
define twig.local_var.value_stack.push_value
$(eval 
   $(__get_new_holder_name__) := $(if $(2),$(2),$($(1)))
   $(call twig.stack.push,$(__get_stack_name__),$(__get_next_stack_size__))
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
#
# Usage:
# $(call twig.local_var.value_stack.pop_value,$1)
#-------------------------------------------------------------------------------
define twig.local_var.value_stack.pop_value
$(eval 

   ifndef $(__get_stack_name__)
      $$(warning $(0): [Variable: $(1)] Popping an empty stack!)
   else
      $(1) := $($(__get_holder_name__))
      $$(call twig.undefine,$$(__get_holder_name__))

      ifeq ($(__get_stack_size__),1)
         $$(call twig.undefine,$$(__get_stack_name__))
      else
         $$(call twig.stack.pop,$$(__get_stack_name__))
      endif
   endif

)
endef
