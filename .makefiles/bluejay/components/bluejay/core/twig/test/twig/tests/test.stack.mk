#-------------------------------------------------------------------------------
# Filename: test.stack.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.isVersion.mk
include ../../../makefiles/twig.stack.mk
include ../../../makefiles/twig.undefine.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
# Arguments:
# $1 - stack name
#-------------------------------------------------------------------------------
define validate_empty_stack
$(eval 
   $(call ut.assert_empty,$(call twig.stack.peek,$(1)))
   $(call ut.assert_equal,$(call twig.stack.size,$(1)),0)
   $(call ut.assert_equal,$(call twig.stack.next_size,$(1)),1)
   $(call ut.assert_empty,$($(1)))
)
endef

define validate_stack
$(eval 
   $(call ut.assert_equal,$(call twig.stack.peek,$(1)),$(2))
   $(call ut.assert_equal,$(call twig.stack.size,$(1)),$(3))
   $(call ut.assert_equal,$(call twig.stack.next_size,$(1)),$(4))
)
endef

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Empty stack)

$(call ut.assert_empty,$(myStack))
$(call validate_empty_stack,myStack)

$(call twig.stack.pop,myStack)
$(call ut.assert_empty,$(myStack))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Push/pop single value)

$(call ut.assert_empty,$(myStack))

$(call twig.stack.push,myStack,a1)
$(call validate_stack,myStack,a1,1,2)

$(call twig.stack.pop,myStack)
$(call validate_empty_stack,myStack)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Push/pop multiple values)

$(call ut.assert_empty,$(myStack))

$(call twig.stack.push,myStack,a1 a2 a3)
$(call validate_stack,myStack,a3,3,4)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,a2,2,3)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,a1,1,2)

$(call twig.stack.pop,myStack)
$(call validate_empty_stack,myStack)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Push/pop multiple times)

$(call ut.assert_empty,$(myStack))

$(call twig.stack.push,myStack,a1)
$(call validate_stack,myStack,a1,1,2)

$(call twig.stack.push,myStack,b1 b2)
$(call validate_stack,myStack,b2,3,4)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,b1,2,3)

$(call twig.stack.push,myStack,c1 c2 c3)
$(call validate_stack,myStack,c3,5,6)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,c2,4,5)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,c1,3,4)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,b1,2,3)

$(call twig.stack.push,myStack,d1)
$(call validate_stack,myStack,d1,3,4)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,b1,2,3)

$(call twig.stack.pop,myStack)
$(call validate_stack,myStack,a1,1,2)

$(call twig.stack.pop,myStack)
$(call validate_empty_stack,myStack)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Find items)

$(call ut.assert_empty,$(myStack))

$(call ut.assert_empty,$(call twig.stack.find,myStack,a1))

val := aa bb ab bb ba ba
$(call twig.stack.push,myStack,$(val))
$(call ut.assert_equal,$(myStack),ba ba bb ab bb aa)

$(call ut.assert_equal,$(call twig.stack.find,myStack,aa),aa)
$(call ut.assert_equal,$(call twig.stack.find,myStack,bb),bb bb)
$(call ut.assert_equal,$(call twig.stack.find,myStack,ab),ab)
$(call ut.assert_equal,$(call twig.stack.find,myStack,ba),ba ba)
$(call ut.assert_empty,$(call twig.stack.find,myStack,cc))

$(call ut.assert_equal,$(call twig.stack.find,myStack,aa bb),bb bb aa)
$(call ut.assert_equal,$(call twig.stack.find,myStack,bb aa),bb bb aa)

$(call twig.undefine,myStack)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Find item count)

$(call ut.assert_empty,$(myStack))

$(call ut.assert_equal,$(call twig.stack.find_count,myStack,a1),0)

val := c3 a1 c3 b2 b2 c3
$(call twig.stack.push,myStack,$(val))
$(call ut.assert_equal,$(myStack),c3 b2 b2 c3 a1 c3)

$(call ut.assert_equal,$(call twig.stack.find_count,myStack,a1),1)
$(call ut.assert_equal,$(call twig.stack.find_count,myStack,b2),2)
$(call ut.assert_equal,$(call twig.stack.find_count,myStack,c3),3)

$(call ut.assert_equal,$(call twig.stack.find_count,myStack,a1 c3),4)
$(call ut.assert_equal,$(call twig.stack.find_count,myStack,a1 b2),3)
