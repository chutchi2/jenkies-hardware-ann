#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.linker.stage_6
   ifneq ($(strip $(call c.get_all_programs)),)
      $$(call function,c.linker.create_rules)
   endif
endef

#-------------------------------------------------------------------------------
define c.linker.create_rules

   $(call local_var,execs,$(sort $(call c.get_all_exe)))
   $(call local_var,execs_with_ext,$(filter %.$(C_EXE_EXT),$(execs)))
   $(call local_var,execs_with_no_ext,$(filter-out %.$(C_EXE_EXT),$(execs)))

   $(foreach &dir,$(sort $(call path,$(execs_with_ext))),\
         $(call function,c.linker.link_rule,\
            $(call c.linker.get_execs_in_dir,$(execs_with_ext),$(&dir)),\
            $(&dir)))

   ifneq ($(strip $(execs_with_no_ext)),)
      $$(call function,c.linker.link_rule_no_extension,$(execs_with_no_ext))
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - execs
# $2 - directory
#-------------------------------------------------------------------------------
define c.linker.get_execs_in_dir
$(sort\
   $(foreach &exe,$(1),\
      $(if $(filter $(2),$(call path,$(&exe))),$(&exe))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - execs
# $2 - build directory
#-------------------------------------------------------------------------------
define c.linker.link_rule

$(1):$(2)/%.$(C_EXE_EXT): | $(2)
	@$(cle.echo) ========== Linking $$@
	@$$(SHOW_DEPS)
	$$(c.linker.link_recipe)

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - executables
#-------------------------------------------------------------------------------
define c.linker.link_rule_no_extension

$(1):%: | $(call path,$(1))
	@$(cle.echo) ========== Linking $$@
	@$$(SHOW_DEPS)
	$$(c.linker.link_recipe)

endef

#-------------------------------------------------------------------------------
define c.linker.link_recipe
   @$(cle.echo) "Linking $(@F)..."
endef
