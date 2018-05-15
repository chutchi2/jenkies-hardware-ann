#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
component := bluejay/standard/c/c.compiler

makefiles := \
   ../c.component_vars.mk \
   ../c.package_vars.mk \
   ../c.program_vars.mk \
   2_discovery/c.include_paths.mk \
   2_discovery/c.source_files.mk \
   2_discovery/c.import.mk \
   2_discovery/c.discovery.mk \
   3_resolve/c.resolve_obj_files.mk \
   3_resolve/c.resolve_mains.mk \
   3_resolve.mk \
   4_read.mk \
   5_assemble.mk \
   6_rules.mk \
   c.diagnostic.mk

$(call bootstrap.include_component_makefiles,$(component),$(makefiles))
#-------------------------------------------------------------------------------
