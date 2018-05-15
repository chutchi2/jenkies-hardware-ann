#-------------------------------------------------------------------------------
# Filename: test.function.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../twig.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - value1
# $2 - value2 (must not be equal to $1)
# $3 - value3 (must be equal to $1)
#-------------------------------------------------------------------------------
define test1
   $(call ut.assert_not_equal,$(1),$(2))
   $(call ut.assert_not_equal,$(2),$(3))
   $(call ut.assert_equal,$(1),$(3))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - value1
# $2 - value2 (must be equal to $1)
# $3 - value3 (must not be equal to $1)
#-------------------------------------------------------------------------------
define test2
   $(call ut.assert_equal,$(1),$(2))
   $(call ut.assert_not_equal,$(2),$(3))
   $(call ut.assert_not_equal,$(1),$(3))
   $(call function,test1,$(1),$(3),$(2))
endef

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,enable/disable/enable trace)

$(call twig.trace.enable)
$(call ut.assert_not_empty,$(TRACE_ENTER))

$(call twig.trace.disable)
$(call ut.assert_empty,$(TRACE_ENTER))

$(call twig.trace.enable)
$(call ut.assert_not_empty,$(TRACE_ENTER))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test1 trace enabled)

$(call twig.trace.enable)
$(call function,test1,a,b,a)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test1 trace disabled)

$(call twig.trace.disable)
$(call function,test1,b,c,b)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,enable/disable/enable call stack trace)

$(call twig.trace.enable_call_stack)
$(call ut.assert_not_empty,$(TRACE_CALL_STACK))

$(call twig.trace.disable_call_stack)
$(call ut.assert_empty,$(TRACE_CALL_STACK))

$(call twig.trace.enable_call_stack)
$(call ut.assert_not_empty,$(TRACE_CALL_STACK))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test1 call stack trace enabled)

$(call twig.trace.enable_call_stack)
$(call function,test1,c,b,c)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test1 call stack trace disabled)

$(call twig.trace.disable_call_stack)
$(call function,test1,d,b,d)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,enable/disable/enable trace all)

$(call twig.trace.enable_all)
$(call ut.assert_not_empty,$(TRACE_ENTER))
$(call ut.assert_not_empty,$(TRACE_CALL_STACK))

$(call twig.trace.disable_all)
$(call ut.assert_empty,$(TRACE_CALL_STACK))
$(call ut.assert_empty,$(TRACE_CALL_STACK))

$(call twig.trace.enable_all)
$(call ut.assert_not_empty,$(TRACE_ENTER))
$(call ut.assert_not_empty,$(TRACE_CALL_STACK))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test1 trace all enabled)

$(call twig.trace.enable_all)
$(call function,test1,e,b,e)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test1 trace all disabled)

$(call twig.trace.disable_all)
$(call function,test1,f,b,f)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test2 trace all enabled)

$(call twig.trace.enable_all)
$(call function,test2,f,f,g)
