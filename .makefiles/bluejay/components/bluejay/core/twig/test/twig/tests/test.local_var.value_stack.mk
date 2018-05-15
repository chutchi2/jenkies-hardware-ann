#-------------------------------------------------------------------------------
# Filename: test.local_var.value_stack.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.isVersion.mk
include ../../../makefiles/twig.local_var.value_stack.mk
include ../../../makefiles/twig.stack.mk
include ../../../makefiles/twig.undefine.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------
myVar_stack_name  = $(call twig.local_var.value_stack.get_stack_name,myVar)
myVar_stack       = $($(myVar_stack_name))

myVar_holder_name = $(call twig.local_var.value_stack.get_holder_name,myVar)
myVar_holder      = $($(myVar_holder_name))

myVar_new_holder_name = $(call twig.local_var.value_stack.get_new_holder_name,myVar)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,get_stack_name)

$(call ut.assert_equal,$(myVar_stack_name),__myVar_values__)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,get_holder_name)

$(call ut.assert_empty,$(myVar_stack))

$(call ut.assert_equal,$(myVar_holder_name),__myVar[0]_value__)

$(myVar_stack_name) := 1
$(call ut.assert_equal,$(myVar_holder_name),__myVar[1]_value__)

$(call twig.local_var.value_stack.get_stack_name,myVar) := 2 1
$(call ut.assert_equal,$(myVar_holder_name),__myVar[2]_value__)

$(call twig.undefine,$(myVar_stack_name))
$(call ut.assert_empty,$(myVar_stack))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,get_new_holder_name)

$(call ut.assert_empty,$(myVar_stack))

$(call ut.assert_equal,$(myVar_new_holder_name),__myVar[1]_value__)

$(call twig.local_var.value_stack.get_stack_name,myVar) := 1
$(call ut.assert_equal,$(myVar_new_holder_name),__myVar[2]_value__)

$(call twig.local_var.value_stack.get_stack_name,myVar) := 2 1
$(call ut.assert_equal,$(myVar_new_holder_name),__myVar[3]_value__)

$(call twig.undefine,$(myVar_stack_name))
$(call ut.assert_empty,$(myVar_stack))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,push_value/pop_value)

stack_name  = $(call twig.local_var.value_stack.get_stack_name,$(1))
stack       = $($(stack_name))

holder_name = $(call twig.local_var.value_stack.get_holder_name,$(1))
holder      = $($(holder_name))

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
# $2 - value name
# $3 - expected value (value stack content)
#-------------------------------------------------------------------------------
define push_value
$(eval 
   $(eval $(1) := $($(2)))
   $(call ut.assert_equal,$($(1)),$($(2)))

   $(call twig.local_var.value_stack.push_value,$(1))

   $(call ut.assert_equal,$(stack),$(3))
   $(call ut.assert_equal,$(holder),$($(2)))
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
# $2 - expected value name (popped value)
# $3 - expected value (value stack content)
#-------------------------------------------------------------------------------
define pop_value
$(eval 
   $(call twig.local_var.value_stack.pop_value,myVar)
   $(call ut.assert_equal,$($(1)),$($(2)))

   $(call ut.assert_equal,$(stack),$(3))
)
endef

val1 := a1
val2 := b1 b2
val3 := c1 c2 c3
val4 :=
val5 :=   e1   e2   e3   e4   e5   
val6 := 6
 
$(call ut.assert_empty,$(myVar))
$(call ut.assert_empty,$(myVar_stack))

$(call push_value,myVar,val1,1)
$(call push_value,myVar,val2,2 1)
$(call push_value,myVar,val3,3 2 1)
$(call push_value,myVar,val4,4 3 2 1)
$(call push_value,myVar,val5,5 4 3 2 1)

myVar := $(val6)
$(call ut.assert_equal,$(myVar),$(val6))

$(call pop_value,myVar,val5,4 3 2 1)
$(call pop_value,myVar,val4,3 2 1)
$(call pop_value,myVar,val3,2 1)
$(call pop_value,myVar,val2,1)
$(call pop_value,myVar,val1)
$(call pop_value,myVar,val1)

$(call ut.assert_empty,$(myVar_stack))
$(call ut.assert_equal,$(myVar),$(val1))

$(call twig.undefine,myVar)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Push explicit value)

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
# $2 - value name
# $3 - expected value (value stack content)
#-------------------------------------------------------------------------------
define push_explicit_value
$(eval 
   $(call twig.local_var.value_stack.push_value,$(1),$($(2)))

   $(call ut.assert_empty,$(myVar))
   $(call ut.assert_equal,$(stack),$(3))
   $(call ut.assert_equal,$(holder),$($(2)))
)
endef

val1 := Woo Hoo!
val2 := Uh Oh!
 
$(call ut.assert_empty,$(myVar))
$(call ut.assert_empty,$(myVar_stack))

$(call push_explicit_value,myVar,val1,1)
$(call push_explicit_value,myVar,val2,2 1)

$(call pop_value,myVar,val2,1)
$(call pop_value,myVar,val1)

$(call ut.assert_empty,$(myVar_stack))
$(call ut.assert_equal,$(myVar),$(val1))

$(call twig.undefine,myVar)
