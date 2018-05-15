#-------------------------------------------------------------------------------
# Filename: twig.isVersion.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Determine if a specific version of make is being used.
#
# Arguments:
# $1 - version to check
#
# Returns:
# $1 if the current version of make is $1 or newer. Otherwise it returns an
# empty value.
#
# Usage:
# $(call twig.isVersion,$1)
#
# Examples:
# $(call twig.isVersion,3.81)
# $(call twig.isVersion,4.0)
#-------------------------------------------------------------------------------
define twig.isVersion
$(filter $(1),$(firstword $(sort $(MAKE_VERSION) $(1))))
endef
