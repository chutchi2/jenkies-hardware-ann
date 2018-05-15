#-------------------------------------------------------------------------------
# Filename: unit_test.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Description:
# Used to output a test header. An optional title may be given.
#
# Arguments:
# $1 - title to display [OPTIONAL]
#
# Usage:
# $(BEGIN_TEST)
# $(call BEGIN_TEST,$1)
#-------------------------------------------------------------------------------
__test_count__ := 0

define BEGIN_TEST
$(eval 
   $(call ut.increment,__test_count__)
   $(info )
   $(info ========== Test $(__test_count__) [ $1 ])
)
endef

#-------------------------------------------------------------------------------
# Description:
# Increments a numeric value by one.
#
# Arguments:
# $1 - name of a variable holding a numeric value
#
# Usage:
# $(call unit_test.increment,$1)
#
# Example:
# count := 3
# $(call unit_test.increment,count)
# $(info count = $(count))
#
# Output:
# count = 4
#-------------------------------------------------------------------------------
define ut.increment
$(eval 
   $1 := $(shell echo $$(($($1)+1)))
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - condition
# $2 - message
#-------------------------------------------------------------------------------
define ut.assert_not_empty
   $(if $(1),,$(error ASSERT FAILED: Empty value$(if $(2),. $(2))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - condition
# $2 - message
#-------------------------------------------------------------------------------
define ut.assert_empty
   $(if $(1),$(error ASSERT FAILED: Value not empty [$(1)]$(if $(2),. $(2))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - val1
# $2 - val2
# $3 - message
#-------------------------------------------------------------------------------
define ut.assert_equal
$(eval 
   ifneq ($(strip $(1)),$(strip $(2)))
      $$(error ASSERT FAILED: [$(1)] != [$(2)]$$(if $(3),. $(3)))
   endif
)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - val1
# $2 - val2
# $3 - message
#-------------------------------------------------------------------------------
define ut.assert_not_equal
$(eval 
   ifeq ($(strip $(1)),$(strip $(2)))
      $$(error ASSERT FAILED: [$(1)] = [$(2)]$$(if $(3),. $(3)))
   endif
)
endef
