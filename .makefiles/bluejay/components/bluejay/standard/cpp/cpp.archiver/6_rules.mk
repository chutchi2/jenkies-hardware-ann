#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.archiver.stage_6
   $(call function,cpp.archiver.create_rules)
endef

#-------------------------------------------------------------------------------
define cpp.archiver.create_rules

   $(call local_var,cpp_libs,\
      $(call cpp.get_static_libs)\
      $(call cpp.get_secondary_static_libs))

   $(foreach &dir,$(sort $(call path,$(cpp_libs))),\
      $(call function,cpp.archiver.archive_rule,\
         $(call cpp.archiver.get_libs_in_dir,$(cpp_libs),$(&dir)),\
         $(&dir)))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - libs
# $2 - directory
#-------------------------------------------------------------------------------
define cpp.archiver.get_libs_in_dir
$(sort\
   $(foreach &lib,$(1),\
      $(if $(filter $(2),$(call path,$(&lib))),$(&lib))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - libs
# $2 - build directory
#-------------------------------------------------------------------------------
define cpp.archiver.archive_rule

$(1):$(2)/%.$(CPP_LIB_EXT): | $(2)
	@$(cle.echo) ========== Building $$@
	@$$(SHOW_DEPS)
	$$(cpp.archiver.archive_recipe)

endef

#-------------------------------------------------------------------------------
define cpp.archiver.archive_recipe
   @$(cle.echo) "Building $(@F)..."
endef
