#-------------------------------------------------------------------------------
# Filename: twig.trace.mk
#
# Description:
# Implements the ability to trace function calls.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
ifndef COMMA
   COMMA :=,
endif

#-------------------------------------------------------------------------------
# Format a list of arguments for printing.
#
# Arguments:
# $1-$9 - function arguments
#
# Returns:
# A preformatted list of arguments in the following form
# [$1],[$2],[$3],[$4],[$5],[$6],[$7],[$8],[$9]
#
# Usage:
# $(call twig.format_args,$1,$2,$3,..,$9)
#-------------------------------------------------------------------------------
define twig.trace.format_args
$(subst ] [,]$(COMMA)[,$(foreach arg, 1 2 3 4 5 6 7 8 9,[$($(arg))]))
endef

#-------------------------------------------------------------------------------
# Print trace information when entering a function.
#
# Arguments:
# $1     - function name
# $2-$10 - arguments to be passed to $1
#
# Usage:
# $(call twig.trace.enter,$1,$2,$3,..,$10)
#-------------------------------------------------------------------------------
define twig.trace.enter
   $(info $(twig.call_stack.indent)Entering function: $(1) $(call \
      twig.trace.format_args,$(2),$(3),$(4),$(5),$(6),$(7),$(8),$(9),$(10)))
endef

#-------------------------------------------------------------------------------
# Print trace information when exiting a function.
#
# Arguments:
# $1 - function name
#
# Usage:
# $(call twig.trace.exit,$1)
#-------------------------------------------------------------------------------
define twig.trace.exit
   $(info $(twig.call_stack.indent)Leaving function : $(1))
endef

#-------------------------------------------------------------------------------
# Enable the ability to trace function calls.
#
# Arguments:
# None
#
# Usage:
# $(call twig.trace.enable)
#-------------------------------------------------------------------------------
define twig.trace.enable
$(eval 
   TRACE_ENTER := twig.trace.enter
   TRACE_EXIT  := twig.trace.exit
)
endef

#-------------------------------------------------------------------------------
# Disable the ability to trace function calls.
#
# Arguments:
# None
#
# Usage:
# $(call twig.trace.disable)
#-------------------------------------------------------------------------------
define twig.trace.disable
$(eval 
   $(call twig.undefine,TRACE_ENTER)
   $(call twig.undefine,TRACE_EXIT)
)
endef

#-------------------------------------------------------------------------------
# Enable the ability to trace the call stack.
#
# Arguments:
# None
#
# Usage:
# $(call twig.trace.enable_call_stack)
#-------------------------------------------------------------------------------
define twig.trace.enable_call_stack
$(eval 
   TRACE_CALL_STACK := twig.call_stack.print
)
endef

#-------------------------------------------------------------------------------
# Disable the ability to trace the call stack.
#
# Arguments:
# None
#
# Usage:
# $(call twig.trace.disable_call_stack)
#-------------------------------------------------------------------------------
define twig.trace.disable_call_stack
$(eval 
   $(call twig.undefine,TRACE_CALL_STACK)
)
endef

#-------------------------------------------------------------------------------
# Enable the ability to trace function calls and the call stack.
#
# Arguments:
# None
#
# Usage:
# $(call twig.trace.enable_all)
#-------------------------------------------------------------------------------
define twig.trace.enable_all
$(eval 
   $(call twig.trace.enable)
   $(call twig.trace.enable_call_stack)
)
endef

#-------------------------------------------------------------------------------
# Disable the ability to trace function calls and the call stack.
#
# Arguments:
# None
#
# Usage:
# $(call twig.trace.disable_all)
#-------------------------------------------------------------------------------
define twig.trace.disable_all
$(eval 
   $(call twig.trace.disable)
   $(call twig.trace.disable_call_stack)
)
endef
