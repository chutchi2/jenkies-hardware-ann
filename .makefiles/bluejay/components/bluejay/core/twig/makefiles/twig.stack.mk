#-------------------------------------------------------------------------------
# Filename: twig.stack.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Push items on the stack.
#
# If multiple items are pushed, they will be pushed in reverse order.
# mystack =
# $(call twig.stack.push,mystack,1)
# mystack = 1
# $(call twig.stack.push,mystack,2 3)
# mystack = 3 2 1
#
# Arguments:
# $1 - stack name
# $2 - items to be pushed
#
# Usage:
# $(call twig.stack.push,$1,$2)
#-------------------------------------------------------------------------------
define twig.stack.push
$(eval 
   $(foreach item,$(2),\
      $(eval $(1) := $(strip $(item) $($(1)))))
)
endef

#-------------------------------------------------------------------------------
# Remove the top item off the stack.
#
# Arguments:
# $1 - stack name
#
# Usage:
# $(call twig.stack.pop,$1)
#-------------------------------------------------------------------------------
define twig.stack.pop
$(eval 
   ifndef $(1)
      $$(warning $(0): [Stack name: $(1)] Popping an empty stack!)
   else
      $(1) := $(strip $(wordlist 2,$(words $($(1))),$($(1))))
   endif
)
endef

#-------------------------------------------------------------------------------
# Return the top item on the stack.
#
# Arguments:
# $1 - stack name
#
# Returns:
# The top item on the stack.
#
# Usage:
# $(call twig.stack.peek,$1)
#-------------------------------------------------------------------------------
define twig.stack.peek
$(firstword $($(1)))
endef

#-------------------------------------------------------------------------------
# Return the number of items on the stack.
#
# Arguments:
# $1 - stack name
#
# Returns:
# The number of items on the stack.
#
# Usage:
# $(call twig.stack.size,$1)
#-------------------------------------------------------------------------------
define twig.stack.size
$(words $($(1)))
endef

#-------------------------------------------------------------------------------
# Return the number of items that will be on the stack after the next push.
#
# Arguments:
# $1 - stack name
#
# Returns:
# The number of items that will be on the stack after the next push.
#
# Usage:
# $(call twig.stack.next_size,$1)
#-------------------------------------------------------------------------------
define twig.stack.next_size
$(words $($(1)) +1)
endef

#-------------------------------------------------------------------------------
# Looks for an item in the stack.
#
# Arguments:
# $1 - stack name
# $2 - items to be searched
#
# Returns:
# The items found.
#
# Usage:
# $(call twig.stack.find,$1,$2)
#-------------------------------------------------------------------------------
define twig.stack.find
$(strip $(filter $(2),$($(1))))
endef

#-------------------------------------------------------------------------------
# Counts the number of items in the stack.
#
# Arguments:
# $1 - stack name
# $2 - items to be searched
#
# Returns:
# The number of items found.
#
# Usage:
# $(call twig.stack.find,$1,$2)
#-------------------------------------------------------------------------------
define twig.stack.find_count
$(words $(call twig.stack.find,$(1),$(2)))
endef
