#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
component := bluejay/standard/c/c.linker

makefiles := \
   3_resolve.mk \
   4_read.mk \
   5_assemble.mk \
   6_rules.mk

$(call bootstrap.include_component_makefiles,$(component),$(makefiles))
#-------------------------------------------------------------------------------
