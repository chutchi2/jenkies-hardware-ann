#-------------------------------------------------------------------------------
# Filename: test.undefine.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.isVersion.mk
include ../../../makefiles/twig.undefine.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - name of variable
#-------------------------------------------------------------------------------
define validate_empty_variable
$(eval 
   $(call ut.assert_empty,$($(1)))

   ifeq ($(call twig.isVersion,3.82),)
      $$(call ut.assert_equal,file,$$(origin $(1)))
   else
      $$(call ut.assert_equal,undefined,$$(origin $(1)))
   endif
)
endef

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Test 1)

a := apple bananas

$(call twig.undefine,a)
$(call validate_empty_variable,a)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Test 2)

a := a
b := b
c := c

$(call twig.undefine,a c)

$(call validate_empty_variable,a)
$(call validate_empty_variable,c)

$(call ut.assert_equal,b,$(b))
$(call ut.assert_equal,file,$(origin b))
