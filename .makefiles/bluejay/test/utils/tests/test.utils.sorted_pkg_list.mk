#-------------------------------------------------------------------------------
# Filename: test.utils.sorted_pkg_list.mk
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
$(call BEGIN_TEST,declare_sorted_pkg_list)

#-------------------------------------------------------------------------------
# $(call function,cpp.add_source_files,$(pkg),$(source_files))
# $(call cpp.get_source_files,$(pkg))
# $(call cpp.get_all_source_files)
# $(call cpp.has_source_files,$(pkg),$(files_to_look_for))
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# cpp.add_source_files,$(pkg),$(source_files)
# cpp.get_source_files,$(pkg)
# cpp.get_all_source_files
# cpp.has_source_files,$(pkg),$(files_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,cpp,source_files,CPP_SOURCE_FILES,CPP_PACKAGES)

barb_list := file_c.cpp file_a.cpp

$(call function,cpp.add_source_files,barb,$(barb_list))
expected := $(sort $(barb_list))
$(call ut.assert_equal,$(expected),$(call cpp.get_source_files,barb))
$(call ut.assert_equal,$(expected),$(barb_CPP_SOURCE_FILES))

expected := file_c.cpp
$(call ut.assert_equal,$(expected),$(call cpp.has_source_files,barb,file_c.cpp))

rob_list := file1.hpp file2.hpp
$(call function,cpp.add_source_files,rob,$(rob_list))
expected := $(sort $(rob_list))
$(call ut.assert_equal,$(expected),$(call cpp.get_source_files,rob))
$(call ut.assert_equal,$(expected),$(rob_CPP_SOURCE_FILES))

expected := file2.hpp
$(call ut.assert_equal,$(expected),$(call cpp.has_source_files,rob,file2.hpp))

CPP_PACKAGES := rob barb
expected := $(sort $(barb_list) $(rob_list))
$(call ut.assert_equal,$(expected),$(call cpp.get_all_source_files))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_pkg_list.add)

# No arguments
# test.utils.sorted_pkg_list.mk:xx: Package name is empty.
$(call function,sorted_pkg_list.add,,,)

# test : no list name : no value
# test.utils.sorted_pkg_list.mk:xx: List name is empty.
$(call function,sorted_pkg_list.add,test,,)

# test : list : no value
$(call function,sorted_pkg_list.add,test,list,)
$(call ut.assert_empty,$(test_list))

# ' test ' : ' list ' : ' 2 '
$(call function,sorted_pkg_list.add, test , list , 2 )
$(call ut.assert_equal,2,$(test_list))

# test : list : 1
$(call function,sorted_pkg_list.add,test,list,1)
$(call ut.assert_equal,1 2,$(test_list))

$(call twig.undefine,test_list)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_pkg_list.get)

empty_list :=
test_list  := hello world

# No arguments
# test.utils.sorted_pkg_list.mk:xx: Package name is empty.
$(call ut.assert_empty,$(call sorted_pkg_list.get,,))

# test : no list name
# test.utils.sorted_pkg_list.mk:xx: List name is empty.
$(call ut.assert_empty,$(call sorted_pkg_list.get,test,))

# test : empty
$(call ut.assert_empty,$(call sorted_pkg_list.get,test,empty))

# test : list
$(call ut.assert_equal,$(test_list),$(call sorted_pkg_list.get,test,list))

# ' test ' : ' list '
$(call ut.assert_equal,$(test_list),$(call sorted_pkg_list.get, test , list ))

$(call twig.undefine,empty_list test_list)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_pkg_list.get_all)

PACKAGES := world universe
world_var := hello world
universe_var := hello universe

# No arguments
# test.utils.sorted_pkg_list.mk:xx: Package list name is empty.
$(call ut.assert_empty,$(call sorted_pkg_list.get_all,,))

# PACKAGES : no list name
# test.utils.sorted_pkg_list.mk:xx: List name is empty.
$(call ut.assert_empty,$(call sorted_pkg_list.get_all,PACKAGES,))

# PACKAGES : var
actual := $(call sorted_pkg_list.get_all,PACKAGES,var)
expected := $(world_var) $(universe_var)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# ' PACKAGES ' : ' var '
actual := $(call sorted_pkg_list.get_all, PACKAGES , var )
expected := $(world_var) $(universe_var)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

$(call twig.undefine,world_var universe_var PACKAGES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,sorted_pkg_list.find)

# No arguments
# test.utils.sorted_pkg_list.mk:xx: Package name is empty.
$(call ut.assert_empty,$(call sorted_pkg_list.find,,,))

# test : no list name
# test.utils.sorted_pkg_list.mk:xx: List name is empty.
$(call ut.assert_empty,$(call sorted_pkg_list.find,test,,))

# test : list : no items
$(call ut.assert_empty,$(call sorted_pkg_list.find,test,list,))

# test : list : cow
$(call ut.assert_empty,$(call sorted_pkg_list.find,test,list,cow))

test_list := cat cow dog

# test : list : cat dog
$(call ut.assert_equal,cat dog,$(call sorted_pkg_list.find,test,list,cat dog))

# ' test ' : ' list ' : ' cat dog '
$(call ut.assert_equal,cat dog,$(call sorted_pkg_list.find, test , list , cat dog ))

$(call twig.undefine,test_list)
