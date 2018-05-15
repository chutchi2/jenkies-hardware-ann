#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.archiver.stage_3

   $(call function,c.archiver.resolve_user_libs)

   $(call function,build_tree.add_build_directories,\
      $(sort $(call c.get_all_lib_dir)\
      $(C_LIB_DIR)))

endef

#-------------------------------------------------------------------------------
define c.archiver.resolve_user_libs
   $(foreach &pkg,$(C_PACKAGES),\
      $(eval \
         $(call function,c.archiver.resolve_user_lib,$(&pkg)) \
         $(call function,c.archiver.resolve_static_lib_deps,$(&pkg))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define c.archiver.resolve_user_lib

   $(call local_var,lib_dir,$(call c.get_lib_dir,$(1)))
   $(call local_var,lib,$(call c.get_lib,$(1)))

   ifeq ($(lib_dir),)
      ifneq ($(lib),)
         lib_dir := $(call path,$(lib))
      else
         lib_dir := $(call path,$(C_LIB_DIR)/$(1))
      endif
      $$(call function,c.set_lib_dir,$(1),$$(lib_dir))
   endif

   ifeq ($(lib),)
      lib := $$(lib_dir)/$(notdir $(1).$(C_LIB_EXT))
      $$(call function,c.set_lib,$(1),$$(lib))
   endif

   ifneq ($$(strip $$(lib_dir)),$$(call path,$$(lib)))
      $$(error '$(1)_LIB_DIR' [$$($(1)_LIB_DIR)] and '$(1)_LIB' [$$($(1)_LIB)] contain conflicting directories)
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define c.archiver.resolve_static_lib_deps

   $(call local_var,lib,$(call c.get_lib,$(1)))
   $(call local_var,objs,$(call c.get_obj_files,$(1)))

   ifneq ($(objs),)

      $$(lib): $$(objs)

      ifeq ($(call c.archiver.resolve_programs,$(1)),)
         $$(call function,c.add_static_libs,$$(lib))
         $$(call function,global.add_static_libs,$$(lib))
      else
         $$(call function,c.add_secondary_static_libs,$$(lib))
         $$(call function,global.add_secondary_static_libs,$$(lib))
      endif

   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define c.archiver.resolve_programs
$(foreach &comp,$(C_PROGRAM_COMPONENTS),\
   $(call $(&comp).get_programs,$(1)))
endef
