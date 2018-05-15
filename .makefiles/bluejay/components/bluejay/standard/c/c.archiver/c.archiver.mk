#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
component := bluejay/standard/c/c.archiver

makefiles := \
   3_resolve.mk

$(call bootstrap.include_component_makefiles,$(component),$(makefiles))
#-------------------------------------------------------------------------------
