#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
component := bluejay/build_tree

makefiles := \
   build_tree.component_vars.mk \
   3_resolve.mk \
   6_rules.mk

$(call bootstrap.include_component_makefiles,$(component),$(makefiles))
