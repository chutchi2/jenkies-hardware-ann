#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.compiler.stage_6
   $(call function,cpp.create_rules)
endef

#-------------------------------------------------------------------------------
reverse = $(if $(wordlist 2,2,$(1)),$(call reverse,$(wordlist 2,$(words $(1)),$(1))) $(firstword $(1)),$(1))

#-------------------------------------------------------------------------------
# Notes:
# When make matches a target to an implicit rule, it looks in the order the
# rules were defined. Therefore rules must be created by directory from the most
# nested to the least nested. If not, a target of
# 'obj/foo/bar/baz.cpp.o' will match the implicit rule
# 'obj/foo/%.cpp.o' if this rule was defined before the implicit rule
# 'obj/foo/bar/%.cpp.o'.
#-------------------------------------------------------------------------------
define cpp.create_rules

   $(call local_var,obj_files,$(basename $(call cpp.get_all_obj_files)))

   $(foreach &ext,$(sort $(suffix $(obj_files))),\
      $(foreach &dir,$(call reverse,$(sort $(call path,$(filter %$(&ext),$(obj_files))))),
         $(call function,cpp.compile_rule,$(&dir),$(&ext:.%=%))))

   $(call function,cpp.depsclean_rule)

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - build directory
# $2 - source file extension
#-------------------------------------------------------------------------------
define cpp.compile_rule

$(1)/%.$(2).$(CPP_OBJ_EXT): | $(1)
	@$(cle.echo) ========== Compiling $$<
	@$$(SHOW_DEPS)
	$$(cpp.compile_recipe)

endef

#-------------------------------------------------------------------------------
define cpp.compile_recipe
   @$(cle.echo) "Compiling $(<F)..."
endef

#-------------------------------------------------------------------------------
define cpp.depsclean_rule

.PHONY: depsclean
depsclean::
	$$(cpp.depsclean_recipe)

endef

#-------------------------------------------------------------------------------
# What if an obj directory is manually configured to be elsewhere?
#-------------------------------------------------------------------------------
define cpp.depsclean_recipe
   $(QUIET)$(call cle.delete_files_recursively,$(CPP_OBJ_DIR),*.$(CPP_DEP_EXT))
endef
