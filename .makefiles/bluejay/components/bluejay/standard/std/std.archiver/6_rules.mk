#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define std.archiver.stage_6
   $(call function,std.archiver.create_rules)
endef

#-------------------------------------------------------------------------------
define std.archiver.create_rules

   $(call local_var,libs,\
      $(call global.get_static_libs)\
      $(call global.get_secondary_static_libs))

   $(foreach &ext,$(sort $(suffix $(libs))),\
      $(foreach &dir,$(call reverse,$(sort $(call path,$(filter %$(&ext),$(libs))))),
         $(call function,std.archiver.archive_rule,$(&dir),$(&ext:.%=%))))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - build directory
# $2 - library extension
#-------------------------------------------------------------------------------
define std.archiver.archive_rule

$(1)/%.$(2): | $(1)
	@$(cle.echo) ========== Building $$@
	@$$(SHOW_DEPS)
	$$(std.archiver.archive_recipe)

endef

#-------------------------------------------------------------------------------
define std.archiver.archive_recipe
   @$(cle.echo) "Building $(@F)..."
endef
