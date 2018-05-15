#-------------------------------------------------------------------------------
# Filename: twig.mk
#
# Description:
# Defines a single form for calling functions with a call stack, local
# variables, and the ability to trace function calls.
#-------------------------------------------------------------------------------
include $(wildcard $(dir $(lastword $(MAKEFILE_LIST)))makefiles/twig*.mk)

#-------------------------------------------------------------------------------
# Usage:
# make TRACE=1
# make TRACE=2
#-------------------------------------------------------------------------------
ifdef TRACE

   $(call twig.trace.enable)

   ifeq ($(TRACE),2)
      $(call twig.trace.enable_call_stack)
   endif

endif

#-------------------------------------------------------------------------------
# Call a function using a call stack, local variables, and the ability to trace
# function calls.
#
# Arguments:
# $1     - function name
# $2-$10 - arguments to be passed to $1
#
# Usage:
# $(call function,$1,$2,$3,..,$10)
#-------------------------------------------------------------------------------
define function
$(eval 
   ifndef $(1)
      $$(warning Function [$(1)] not defined!)
   else
      $(call try_function,$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10))
   endif
)
endef

#-------------------------------------------------------------------------------
define try_function
$(eval 
   $(call twig.call_stack.push,$(1))
   $($(TRACE_CALL_STACK))
   $(call $(TRACE_ENTER),$(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10))
   $(eval $(call $(1),$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10)))
   $(call twig.local_var.scope.clear,$(twig.call_stack.top))
   $(call $(TRACE_EXIT),$(1))
   $(call twig.call_stack.pop)
   $($(TRACE_CALL_STACK))
)
endef

#-------------------------------------------------------------------------------
# Define a local variable.
#
# Local variables work by pushing values onto a stack at the point the variable
# is defined (by using this method).
#
# At the end of each function, any local variables defined within the function
# have their values reset to the value popped off the stack. If a variable had
# no prior value, the variable is undefined.
#
# ********************************** WARNING **********************************
#
# Within the same function, take care not to assign a variable before it is
# defined with this method. Doing so will change the value the calling function
# sees when the function returns.
#
# Example:
# define func
#    $(call twig.debug.print_var,fruit)   # fruit = <empty>
#    $(call local_var,fruit,apple)        # stack.push(<empty>)
#    $(call twig.debug.print_var,fruit)   # fruit = apple
#    $(call function,good)
#    $(call twig.debug.print_var,fruit)   # fruit = apple
#    $(call function,bad)
#    $(call twig.debug.print_var,fruit)   # fruit = grape
# endef                                   # stack.pop => <empty>
#
# define good
#    $(call twig.debug.print_var,fruit)   # fruit = apple
#    $(call local_var,fruit,orange)       # stack.push(apple)
#    $(call twig.debug.print_var,fruit)   # fruit = orange
#    fruit := grape
#    $(call twig.debug.print_var,fruit)   # fruit = grape
# endef                                   # stack.pop => apple
#
# define bad
#    $(call twig.debug.print_var,fruit)   # fruit = apple
#    fruit := grape
#    $(call twig.debug.print_var,fruit)   # fruit = grape
#    $(call local_var,fruit,banana)       # stack.push(grape)
#    $(call twig.debug.print_var,fruit)   # fruit = banana
# endef                                   # stack.pop => grape
#
# ********************************** WARNING **********************************
#
# Arguments:
# $1 - variable name
# $2 - value
# $3 - default value if $2 is empty
#
# Usage:
# $(call local_var,$1,$2,$3)
#-------------------------------------------------------------------------------
define local_var
$(eval 
   $(call twig.local_var.scope.add_var,$(call twig.call_stack.top),$(1))
   $(1) := $(strip $(if $(strip $(2)),$(2),$(3)))
)
endef
