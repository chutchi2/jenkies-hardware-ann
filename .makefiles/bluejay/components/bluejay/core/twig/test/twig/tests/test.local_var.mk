#-------------------------------------------------------------------------------
# Filename: test.local_var.mk
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

define test1
   $(call local_var,a,$(1))
   $(call local_var,b,$(2),<default>)

   $(call ut.assert_equal,$(a),$(1))
   $(call ut.assert_equal,$(b),$(if $(2),$(2),<default>))
endef

define test2
   $(call local_var,a,$(1))
   $(call local_var,b,$(2),<default>)
   $(call local_var,d,hi)

   $(call ut.assert_equal,$(a),$(1))
   $(call ut.assert_equal,$(b),$(if $(2),$(2),<default>))
   $(call ut.assert_equal,$(d),hi)

   $(call function,test1,$(3),$(4))

   $(call ut.assert_equal,$(a),$(1))
   $(call ut.assert_equal,$(b),$(if $(2),$(2),<default>))
   $(call ut.assert_equal,$(d),hi)
endef

define test3
   $(call local_var,a,$(1))
   $(call local_var,b,$(2),<default>)
   $(call local_var,c,jello)
   $(call local_var,d,red)

   $(call ut.assert_equal,$(a),$(1))
   $(call ut.assert_equal,$(b),$(if $(2),$(2),<default>))
   $(call ut.assert_equal,$(c),jello)
   $(call ut.assert_equal,$(d),red)

   $(call function,test2,$(3),$(4),$(5),$(6))

   $(call ut.assert_equal,$(a),$(1))
   $(call ut.assert_equal,$(b),$(if $(2),$(2),<default>))
   $(call ut.assert_equal,$(c),jello)
   $(call ut.assert_equal,$(d),red)
endef

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,single function no previous values)

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))

$(call function,test1,a1,b2)
$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))

$(call function,test1,c3)
$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,single function with existing values)

a := foo
b := bar

$(call ut.assert_equal,$(a),foo)
$(call ut.assert_equal,$(b),bar)

$(call function,test1,aa,bb)
$(call ut.assert_equal,$(a),foo)
$(call ut.assert_equal,$(b),bar)

$(call twig.undefine,a b)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test2 calls test1)

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))
$(call ut.assert_empty,$(d))

$(call function,test2,aa,bb,cc,dd)

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))
$(call ut.assert_empty,$(d))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,test3 calls test2 calls test1)

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))
$(call ut.assert_empty,$(c))
$(call ut.assert_empty,$(d))

$(call function,test3,aa,bb,cc,dd,ee,ff)

$(call ut.assert_empty,$(a))
$(call ut.assert_empty,$(b))
$(call ut.assert_empty,$(c))
$(call ut.assert_empty,$(d))
