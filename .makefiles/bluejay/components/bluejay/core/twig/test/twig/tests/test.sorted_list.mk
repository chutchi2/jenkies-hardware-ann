#-------------------------------------------------------------------------------
# Filename: test.sorted_list.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.isVersion.mk
include ../../../makefiles/twig.sorted_list.mk
include ../../../makefiles/twig.undefine.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,add items)

$(call ut.assert_empty,$(myList))

$(call twig.sorted_list.add,myList,a)
$(call ut.assert_equal,$(myList),a)

$(call twig.sorted_list.add,myList,c d b)
$(call ut.assert_equal,$(myList),a b c d)

$(call twig.undefine,myList)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find items)

$(call ut.assert_empty,$(myList))

val := aa bb ab bb ba ba
$(call twig.sorted_list.add,myList,$(val))
$(call ut.assert_equal,$(myList),$(sort $(val)))

$(call ut.assert_equal,$(call twig.sorted_list.find,myList,aa),aa)
$(call ut.assert_equal,$(call twig.sorted_list.find,myList,bb),bb)
$(call ut.assert_equal,$(call twig.sorted_list.find,myList,ab),ab)
$(call ut.assert_equal,$(call twig.sorted_list.find,myList,ba),ba)
$(call ut.assert_empty,$(call twig.sorted_list.find,myList,cc))
