#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
component := bluejay/standard/cpp/cpp.compiler

makefiles := \
   ../cpp.component_vars.mk \
   ../cpp.package_vars.mk \
   ../cpp.program_vars.mk \
   2_discovery/cpp.include_paths.mk \
   2_discovery/cpp.source_files.mk \
   2_discovery/cpp.import.mk \
   2_discovery/cpp.discovery.mk \
   3_resolve/cpp.resolve_obj_files.mk \
   3_resolve/cpp.resolve_mains.mk \
   3_resolve.mk \
   4_read.mk \
   5_assemble.mk \
   6_rules.mk \
   cpp.diagnostic.mk

$(call bootstrap.include_component_makefiles,$(component),$(makefiles))
#-------------------------------------------------------------------------------
