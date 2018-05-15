#-------------------------------------------------------------------------------
# Filename: test.local_var.scope.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.debug.mk
include ../../../makefiles/twig.isVersion.mk
include ../../../makefiles/twig.local_var.scope.mk
include ../../../makefiles/twig.local_var.value_stack.mk
include ../../../makefiles/twig.sorted_list.mk
include ../../../makefiles/twig.stack.mk
include ../../../makefiles/twig.undefine.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------
list_name  = $(call twig.local_var.scope.get_list_name,$(myScope))
list       = $($(list_name))

stack_name  = $(call twig.local_var.value_stack.get_stack_name,$(1))
stack       = $($(stack_name))

holder_name = $(call twig.local_var.value_stack.get_holder_name,$(1))
holder      = $($(holder_name))

new_holder_name = $(call twig.local_var.value_stack.get_new_holder_name,$(1))
new_holder      = $($(new_holder_name))

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
# $2 - expected value (list content)
# $3 - expected value (value stack content)
# $4 - expected value (value holder content)
#-------------------------------------------------------------------------------
define validate_list
$(eval 
   $(call ut.assert_equal,$(list),$(2))
   $(call ut.assert_equal,$(stack),$(3))
   $(call ut.assert_equal,$(holder),$(4))
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list content
#-------------------------------------------------------------------------------
define validate_empty_list
$(eval 
   $(if ,$(call twig.debug.print_var,$(list_name)))

   $(call ut.assert_empty,$(list))
   $(foreach var,$(1),$(call validate_empty_value_stack,$(var)))
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
#-------------------------------------------------------------------------------
define validate_empty_value_stack
$(eval 
   $(if ,$(call twig.debug.print_var,$(stack_name)))
   $(if ,$(call twig.debug.print_var,$(new_holder_name)))

   $(call ut.assert_empty,$(stack))
   $(call ut.assert_empty,$(new_holder))
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - variable name
#-------------------------------------------------------------------------------
define print_list
$(eval 
   $(call twig.debug.print_var,$(list_name))
   $(call twig.debug.print_var,$(stack_name))
   $(call twig.debug.print_var,$(holder_name))
)
endef

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,get_list_name)

myScope := <empty>
$(call ut.assert_equal,$(list_name),__<empty>_local_vars__)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,add_var/clear single scope - no predefined values)

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))
$(call ut.assert_empty,$(c))

myScope := <empty>
$(call ut.assert_empty,$(list))

$(call twig.local_var.scope.add_var,$(myScope),a)
$(call validate_list,a,a,1,__<EOS>__)
a := a1

$(call twig.local_var.scope.add_var,$(myScope),b)
$(call validate_list,b,a b,1,__<EOS>__)
b := b2

$(call twig.local_var.scope.add_var,$(myScope),c)
$(call validate_list,c,a b c,1,__<EOS>__)
c := c3

$(call ut.assert_equal,$(a),a1)
$(call ut.assert_equal,$(b),b2)
$(call ut.assert_equal,$(c),c3)

list_content := $(list)
$(call twig.local_var.scope.clear,$(myScope))
$(call validate_empty_list,$(list_content))

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))
$(call ut.assert_empty,$(c))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,add_var/clear single scope - with predefined values)

a := foo
b := bar

myScope := <empty>
$(call ut.assert_empty,$(list))

$(call twig.local_var.scope.add_var,$(myScope),a)
$(call validate_list,a,a,1,foo)
a := a1

$(call twig.local_var.scope.add_var,$(myScope),b)
$(call validate_list,b,a b,1,bar)
b := b2

$(call twig.local_var.scope.add_var,$(myScope),c)
$(call validate_list,c,a b c,1,__<EOS>__)
c := c3

$(call ut.assert_equal,$(a),a1)
$(call ut.assert_equal,$(b),b2)
$(call ut.assert_equal,$(c),c3)

list_content := $(list)
$(call twig.local_var.scope.clear,$(myScope))
$(call validate_empty_list,$(list_content))

$(call ut.assert_equal,$(a),foo)
$(call ut.assert_equal,$(b),bar)
$(call ut.assert_empty,$(c))

$(call twig.undefine,a b)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,add same variable twice)

$(call ut.assert_empty,$(a))

myScope := <empty>
$(call ut.assert_empty,$(list))

$(call twig.local_var.scope.add_var,$(myScope),a)
$(call validate_list,a,a,1,__<EOS>__)
a := a1

$(call twig.local_var.scope.add_var,$(myScope),a)
$(call validate_list,a,a,1,__<EOS>__)
a := a1 a2

list_content := $(list)
$(call twig.local_var.scope.clear,$(myScope))
$(call validate_empty_list,$(list_content))

$(call ut.assert_empty,$(a))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,add_var/clear multiple scope)

x := x-large

myScope := <empty>
$(call ut.assert_empty,$(list))

$(call twig.local_var.scope.add_var,$(myScope),x)
$(call validate_list,x,x,1,x-large)
x := large

myScope := func1
$(call twig.local_var.scope.add_var,$(myScope),x)
$(call validate_list,x,x,2 1,large)
x := medium

$(call twig.local_var.scope.add_var,$(myScope),y)
$(call validate_list,y,x y,1,__<EOS>__)
y := yellow

myScope := func2
$(call twig.local_var.scope.add_var,$(myScope),x)
$(call validate_list,x,x,3 2 1,medium)
x := small

$(call twig.local_var.scope.clear,$(myScope))
$(call ut.assert_equal,$(x),medium)
$(call ut.assert_equal,$(y),yellow)
$(call validate_list,x,,2 1,large)
$(call validate_list,y,,1,__<EOS>__)

myScope := func1
$(call twig.local_var.scope.clear,$(myScope))
$(call ut.assert_equal,$(x),large)
$(call ut.assert_empty,$(y))
$(call validate_list,x,,1,x-large)
$(call validate_list,y,,,)

myScope := <empty>
$(call twig.local_var.scope.clear,$(myScope))
$(call validate_empty_list,$(list_content))
$(call ut.assert_equal,$(x),x-large)
