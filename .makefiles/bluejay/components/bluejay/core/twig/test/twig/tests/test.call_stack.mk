#-------------------------------------------------------------------------------
# Filename: test.call_stack.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.call_stack.mk
include ../../../makefiles/twig.stack.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Empty stack)

$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)
$(call ut.assert_equal,$(call twig.call_stack.top),<makefile>[1])

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,push/pop)

$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)

$(call twig.call_stack.push,test1)
$(call twig.call_stack.push,test2)
$(call twig.call_stack.push,test3)

$(call ut.assert_equal,$(call twig.call_stack.peek),test3)
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.peek),test2)
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.peek),test1)
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,push/pop an empty string)

$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)

$(call twig.call_stack.push,  )
$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,pop call stack too many times)

$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)
$(call twig.call_stack.pop)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,top)

$(call ut.assert_equal,$(call twig.call_stack.peek),<makefile>)

$(call twig.call_stack.push,test1)
$(call twig.call_stack.push,test1)
$(call twig.call_stack.push,test2)
$(call twig.call_stack.push,test1)
$(call twig.call_stack.push,test3)

$(call ut.assert_equal,$(call twig.call_stack.top),test3[1])
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.top),test1[3])
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.top),test2[1])
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.top),test1[2])
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.top),test1[1])
$(call twig.call_stack.pop)
$(call ut.assert_equal,$(call twig.call_stack.top),<makefile>[1])
