#-------------------------------------------------------------------------------
# Filename: test.isVersion.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk

include ../../../makefiles/twig.isVersion.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Version 3.80)
$(call ut.assert_equal,3.80,$(call twig.isVersion,3.80))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Version 3.81)
$(call ut.assert_equal,3.81,$(call twig.isVersion,3.81))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Version 3.82)

ifneq ($(filter $(MAKE_VERSION),3.81),)
   $(call ut.assert_empty,$(call twig.isVersion,3.82))
else
   $(call ut.assert_equal,3.82,$(call twig.isVersion,3.82))
endif

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Version 4.0)

ifneq ($(filter $(MAKE_VERSION),3.81 3.82),)
   $(call ut.assert_empty,$(call twig.isVersion,4.0))
else
   $(call ut.assert_equal,4.0,$(call twig.isVersion,4.0))
endif

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,Version 4.1)

ifneq ($(filter $(MAKE_VERSION),3.81 3.82 4.0),)
   $(call ut.assert_empty,$(call twig.isVersion,4.1))
else
   $(call ut.assert_equal,4.1,$(call twig.isVersion,4.1))
endif
