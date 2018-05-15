#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.archiver.stage_6
   $(call function,c.archiver.create_rules)
endef

#-------------------------------------------------------------------------------
define c.archiver.create_rules

   $(call local_var,c_libs,\
      $(call c.get_static_libs)\
      $(call c.get_secondary_static_libs))

   $(foreach &dir,$(sort $(call path,$(c_libs))),\
      $(call function,c.archiver.archive_rule,\
         $(call c.archiver.get_libs_in_dir,$(c_libs),$(&dir)),\
         $(&dir)))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - libs
# $2 - directory
#-------------------------------------------------------------------------------
define c.archiver.get_libs_in_dir
$(sort\
   $(foreach &lib,$(1),\
      $(if $(filter $(2),$(call path,$(&lib))),$(&lib))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - libs
# $2 - build directory
#-------------------------------------------------------------------------------
define c.archiver.archive_rule

$(1):$(2)/%.$(C_LIB_EXT): | $(2)
	@$(cle.echo) ========== Building $$@
	@$$(SHOW_DEPS)
	$$(c.archiver.archive_recipe)

endef

#-------------------------------------------------------------------------------
define c.archiver.archive_recipe
   @$(cle.echo) "Building $(@F)..."
endef
