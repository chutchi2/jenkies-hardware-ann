#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define build_tree.stage_6
   $(call function,build_tree.create_rules)
endef

#-------------------------------------------------------------------------------
define build_tree.create_rules

   $(foreach &dir,$(BUILD_DIRS),\
      $(call function,build_tree.make_directory_rule,$(&dir)))

   $(call function,build_tree.clean_rule,$(CLEAN_DIRS))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - build directory
#-------------------------------------------------------------------------------
define build_tree.make_directory_rule

$1:
	$$(build_tree.make_directory_recipe)

endef

#-------------------------------------------------------------------------------
define build_tree.make_directory_recipe
   $(QUIET)$(cle.make_dir) $@
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - build directories to delete
#-------------------------------------------------------------------------------
define build_tree.clean_rule

.PHONY: clean
clean::
	$$(call build_tree.clean_recipe,$(1))

endef

#-------------------------------------------------------------------------------
define build_tree.clean_recipe
   $(cle.delete_dirs) $(1)
endef
