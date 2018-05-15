#-------------------------------------------------------------------------------
# Filename: test.debug.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.debug.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,DEBUG_ENTRY)

define test1
   $(DEBUG_ENTRY)
endef

$(call test1,a1,b2,c3,d4,e5,f6,g7,h8,i9,j10)
$(call test1,,b2,\
   ,d4,,f6,,\
   h8,,j10)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,DEBUG_PRINT_ARGS)

define test2
   $(DEBUG_PRINT_ARGS)
endef

$(call test2,a1,b2,c3,d4,e5,f6,g7,h8,i9,j10)

$(info )

$(call test2,,b2,\
   ,d4,,f6,,\
   h8,,j10)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,print_var)

a := a1
b := b1 b2
c := \
   c1 \
   c2 \
   c3
d :=   

$(call twig.debug.print_var,a)
$(call twig.debug.print_var,b)
$(call twig.debug.print_var,c)
$(call twig.debug.print_var,d)
