#-------------------------------------------------------------------------------
# Filename: test.utils.unsorted_list.mk
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
$(call BEGIN_TEST,declare_unsorted_list)

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
$(call function,declare_unsorted_list,cpp,system_includes,CPP_SYSTEM_INCLUDES)

dir_1 := obj/rob obj/barb obj/barb

$(call function,cpp.add_system_includes,$(dir_1))
expected := $(dir_1)
$(call ut.assert_equal,$(expected),$(call cpp.get_system_includes))
$(call ut.assert_equal,$(expected),$(CPP_SYSTEM_INCLUDES))

expected := obj/barb obj/barb
$(call ut.assert_equal,$(expected),$(call cpp.has_system_includes,obj/barb))

expected := obj/rob
$(call ut.assert_equal,$(expected),$(call cpp.has_system_includes,obj/rob))
