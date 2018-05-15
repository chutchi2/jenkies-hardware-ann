#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.linker.stage_6
   ifneq ($(strip $(call cpp.get_all_programs)),)
      $$(call function,cpp.linker.create_rules)
   endif
endef

#-------------------------------------------------------------------------------
define cpp.linker.create_rules

   $(call local_var,execs,$(sort $(call cpp.get_all_exe)))
   $(call local_var,execs_with_ext,$(filter %.$(CPP_EXE_EXT),$(execs)))
   $(call local_var,execs_with_no_ext,$(filter-out %.$(CPP_EXE_EXT),$(execs)))

   $(foreach &dir,$(sort $(call path,$(execs_with_ext))),\
      $(call function,cpp.linker.link_rule,\
         $(call cpp.linker.get_execs_in_dir,$(execs_with_ext),$(&dir)),\
         $(&dir)))

   ifneq ($(strip $(execs_with_no_ext)),)
      $$(call function,cpp.linker.link_rule_no_extension,$(execs_with_no_ext))
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - execs
# $2 - directory
#-------------------------------------------------------------------------------
define cpp.linker.get_execs_in_dir
$(sort\
   $(foreach &exe,$(1),\
      $(if $(filter $(2),$(call path,$(&exe))),$(&exe))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - execs
# $2 - build directory
#-------------------------------------------------------------------------------
define cpp.linker.link_rule

$(1):$(2)/%.$(CPP_EXE_EXT): | $(2)
	@$(cle.echo) ========== Linking $$@
	@$$(SHOW_DEPS)
	$$(cpp.linker.link_recipe)

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - executables
#-------------------------------------------------------------------------------
define cpp.linker.link_rule_no_extension

$(1):%: | $(call path,$(1))
	@$(cle.echo) ========== Linking $$@
	@$$(SHOW_DEPS)
	$$(cpp.linker.link_recipe)

endef

#-------------------------------------------------------------------------------
define cpp.linker.link_recipe
   @$(cle.echo) "Linking $(@F)..."
endef
