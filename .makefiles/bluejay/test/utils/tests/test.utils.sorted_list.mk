#-------------------------------------------------------------------------------
# Filename: test.utils.sorted_list.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk
BLUEJAY_COMPONENTS := bluejay/null
include ../../../bluejay.mk

all: ; @:

#-------------------------------------------------------------------------------
# Test Variables
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,declare_sorted_list)

#-------------------------------------------------------------------------------
# $(call function,cpp.add_system_includes,$(system_includes))
# $(call cpp.get_system_includes)
# $(call cpp.has_system_includes,$(includes_to_look_for))
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# cpp.add_system_includes,$(system_includes)
# cpp.get_system_includes
# cpp.has_system_includes,$(includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,system_includes,CPP_SYSTEM_INCLUDES)

dir_1 := obj/rob obj/barb 

$(call function,cpp.add_system_includes,$(dir_1))
expected := $(sort $(dir_1))
$(call ut.assert_equal,$(expected),$(call cpp.get_system_includes))
$(call ut.assert_equal,$(expected),$(CPP_SYSTEM_INCLUDES))

expected := obj/rob
$(call ut.assert_equal,$(expected),$(call cpp.has_system_includes,obj/rob))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_list.add)

# No arguments
# test.utils.sorted_list.mk:xx: List name is empty.
$(call function,sorted_list.add,,)

# list : no value
$(call function,sorted_list.add,list,)
$(call ut.assert_empty,$(list))

# list : 2
$(call function,sorted_list.add,list,2)
$(call ut.assert_equal,2,$(list))

# ' list ' : ' 1 '
$(call function,sorted_list.add, list , 1 )
$(call ut.assert_equal,1 2,$(list))

$(call twig.undefine,list)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_list.get)

empty :=
list  := hello world

# No list name
# test.utils.sorted_list.mk:xx: List name is empty.
$(call ut.assert_empty,$(call sorted_list.get,))

# empty
$(call ut.assert_empty,$(call sorted_list.get,empty))

# list
$(call ut.assert_equal,$(list),$(call sorted_list.get,list))

# ' list '
$(call ut.assert_equal,$(list),$(call sorted_list.get, list ))

$(call twig.undefine,empty_list test_list)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_list.find)

# No arguments
# test.utils.sorted_list.mk:xx: List name is empty.
$(call ut.assert_empty,$(call sorted_list.find,,))

# list : no items
$(call ut.assert_empty,$(call sorted_list.find,list,))

# list : cow
$(call ut.assert_empty,$(call sorted_list.find,list,cow))

list := cat cow dog

# list : cat dog
$(call ut.assert_equal,cat dog,$(call sorted_list.find,list,cat dog))

# ' list ' : ' cat dog '
$(call ut.assert_equal,cat dog,$(call sorted_list.find, list , cat dog ))

$(call twig.undefine,list)

