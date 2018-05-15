#-------------------------------------------------------------------------------
# Filename: test.utils.pkg_var.mk
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
$(call BEGIN_TEST,declare_pkg_var)

#-------------------------------------------------------------------------------
# $(call function,cpp.set_obj_dir,$(pkg),$(obj_dir))
# $(call cpp.get_obj_dir,$(pkg))
# $(call cpp.get_all_obj_dir)
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# cpp.set_obj_dir,$(pkg),$(obj_dir)
# cpp.get_obj_dir,$(pkg)
# cpp.get_all_obj_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,obj_dir,OBJ_DIR,CPP_PACKAGES)

dir_1 := obj/barb

$(call function,cpp.set_obj_dir,barb,$(dir_1))
expected := $(dir_1)
$(call ut.assert_equal,$(expected),$(call cpp.get_obj_dir,barb))
$(call ut.assert_equal,$(expected),$(barb_OBJ_DIR))

dir_2 := obj/rob

$(call function,cpp.set_obj_dir,rob,$(dir_2))
expected := $(dir_2)
$(call ut.assert_equal,$(expected),$(call cpp.get_obj_dir,rob))
$(call ut.assert_equal,$(expected),$(rob_OBJ_DIR))

CPP_PACKAGES := rob barb
expected := $(dir_2) $(dir_1)
$(call ut.assert_equal,$(expected),$(call cpp.get_all_obj_dir))

$(call twig.undefine,dir_1 dir_2 CPP_PACKAGES expected)
$(call twig.undefine,cpp.set_obj_dir cpp.get_obj_dir cpp.get_all_obj_dir)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,pkg_var.set)

# No arguments
# test.utils.pkg_var.mk:xx: Package name is empty.
$(call function,pkg_var.set,,,)

# test : no var name : no value
# test.utils.pkg_var.mk:xx: Variable name is empty.
$(call function,pkg_var.set,test,,)

# test : var : no value
$(call function,pkg_var.set,test,var,)
$(call ut.assert_empty,$(test_var))

# ' test ' : ' var ' : ' 1 '
$(call function,pkg_var.set, test , var , 1 )
$(call ut.assert_equal,1,$(test_var))

# test : var : 2
$(call function,pkg_var.set,test,var,2)
$(call ut.assert_equal,2,$(test_var))

$(call twig.undefine,test_var)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,pkg_var.get)

empty_var :=
test_var  := hello_world

# No arguments
# test.utils.pkg_var.mk:xx: Package name is empty.
$(call ut.assert_empty,$(call pkg_var.get,,))

# test : no var name
# test.utils.pkg_var.mk:xx: Variable name is empty.
$(call ut.assert_empty,$(call pkg_var.get,test,))

# test : empty
$(call ut.assert_empty,$(call pkg_var.get,test,empty))

# test : var
$(call ut.assert_equal,$(test_var),$(call pkg_var.get,test,var))

# ' test ' : ' var '
$(call ut.assert_equal,$(test_var),$(call pkg_var.get, test , var ))

$(call twig.undefine,test_var)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,pkg_var.get_all)

PACKAGES := world universe
world_var := hello_world
universe_var := hello_universe

# No arguments
# test.utils.pkg_var.mk:xx: Package list name is empty.
$(call ut.assert_empty,$(call pkg_var.get_all,,))

# PACKAGES : no var name
# test.utils.pkg_var.mk:xx: Variable name is empty.
$(call ut.assert_empty,$(call pkg_var.get_all,PACKAGES,))

# PACKAGES : var
actual := $(call pkg_var.get_all,PACKAGES,var)
expected := $(world_var) $(universe_var)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# ' PACKAGES ' : ' var '
actual := $(call pkg_var.get_all, PACKAGES , var )
expected := $(world_var) $(universe_var)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

$(call twig.undefine,world_var universe_var PACKAGES)
