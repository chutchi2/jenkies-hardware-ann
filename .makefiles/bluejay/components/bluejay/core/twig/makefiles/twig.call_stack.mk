#-------------------------------------------------------------------------------
# Filename: twig.call_stack.mk
#
# Description:
# Implements a function call stack.
#-------------------------------------------------------------------------------
__call_stack__ := <makefile>

#-------------------------------------------------------------------------------
# Push a function onto the call stack.
#
# Arguments:
# $1 - function name
#
# Usage:
# $(call twig.call_stack.push,$1)
#-------------------------------------------------------------------------------
define twig.call_stack.push
$(eval 
   $(call twig.stack.push,__call_stack__,$(1))
)
endef

#-------------------------------------------------------------------------------
# Pop a function off of the call stack.
#
# Arguments:
# None
#
# Usage:
# $(call twig.call_stack.pop)
#-------------------------------------------------------------------------------
define twig.call_stack.pop
$(eval 
   ifeq ($(strip $(__call_stack__)),<makefile>)
      $$(warning Call stack popped too many times!)
   else
      $$(call twig.stack.pop,__call_stack__)
   endif
)
endef

#-------------------------------------------------------------------------------
# Return the function at the top of the call stack.
#
# Arguments:
# None
#
# Returns:
# The function at the top of the call stack.
#
# Usage:
# $(call twig.call_stack.peek)
#-------------------------------------------------------------------------------
define twig.call_stack.peek
$(call twig.stack.peek,__call_stack__)
endef

#-------------------------------------------------------------------------------
# Return the function at the top of the call stack as a fully qualified function
# name.
#
# A fully qualified function name has the form:
# function_name[n]
#
# Where:
# function_name is the name of the function
# n             is the instance number of the function (in the event a function
#               occurs more than once on the call stack)
#
# Arguments:
# None
#
# Returns:
# The value at the top of the call stack as a fully qualified function name.
#
# Usage:
# $(call twig.call_stack.top)
#-------------------------------------------------------------------------------
define twig.call_stack.top
$(call twig.call_stack.peek)[$(call twig.stack.find_count,__call_stack__,$(call twig.call_stack.peek))]
endef

#-------------------------------------------------------------------------------
# Returns a space for each function on the call stack.
#
# Arguments:
# None
#
# Returns:
# A space for each function on the call stack.
#
# Usage:
# $(twig.trace.indent)
#-------------------------------------------------------------------------------
define twig.call_stack.indent
$(foreach func,$(wordlist 2,$(words $(__call_stack__)),$(__call_stack__)),)
endef

#-------------------------------------------------------------------------------
# Print the content of the call stack.
#
# Arguments:
# None
#
# Usage:
# $(call twig.call_stack.print)
#-------------------------------------------------------------------------------
define twig.call_stack.print
   $(info $(twig.call_stack.indent)Call Stack: $(__call_stack__))
endef
