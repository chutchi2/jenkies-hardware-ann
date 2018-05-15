#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.linker.stage_3

   $(call function,c.linker.resolve_programs)

   $(call local_var,build_dirs,\
      $(sort \
         $(call c.get_all_exe_dir) \
         $(C_EXE_DIR)))

   $(call function,build_tree.add_build_directories,$(build_dirs))

endef

#-------------------------------------------------------------------------------
define c.linker.resolve_programs

   $(foreach &prog,$(call c.get_all_programs),\
      $(eval \
         $(call function,c.linker.resolve_exe,$(&prog)) \
         $(call function,c.linker.resolve_exe_deps,$(&prog))))

   $(call function,global.add_executables,$(call c.get_all_exe))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - program
#-------------------------------------------------------------------------------
define c.linker.resolve_exe

   $(call local_var,exe_dir,$(call c.get_exe_dir,$(1)))
   $(call local_var,exe,$(call c.get_exe,$(1)))

   ifeq ($(exe_dir),)

      ifneq ($(exe),)
         exe_dir := $(call path,$(exe))
      else
         exe_dir := $(call path,$(C_EXE_DIR)/$(1))
      endif

      $$(call function,c.set_exe_dir,$(1),$$(exe_dir))

   endif

   ifeq ($(exe),)
      exe := $$(exe_dir)/$(patsubst %.,%,$(notdir $(1)).$(C_EXE_EXT))
      $$(call function,c.set_exe,$(1),$$(exe))
   endif

   ifneq ($$(strip $$(exe_dir)),$$(call path,$$(exe)))
      $$(error '$(1)_EXE_DIR' [$$($(1)_EXE_DIR)] and '$(1)_EXE' [$$($(1)_EXE)] contain conflicting directories)
   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - program
#-------------------------------------------------------------------------------
define c.linker.resolve_exe_deps

   $(call local_var,exe_pkg,$(call c.get_exe_pkg,$(1)))
   $(call local_var,exe_main_obj,$(call c.get_exe_main_obj,$(1)))

   ifeq ($(call c.get_exe_deps,$(1)),)
      $$(call function,c.add_exe_deps,$(1),\
         $$(exe_main_obj)\
         $$(call c.linker.resolve_exe_obj_files,$(exe_pkg))\
         $$(call c.linker.resolve_exe_static_libs))
   endif

   $$(call local_var,exe,$$(call c.get_exe,$(1)))
   $$(exe) : $$(call c.get_exe_deps,$(1))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define c.linker.resolve_exe_obj_files
$(filter-out \
   $(foreach &comp,$(C_EXE_DEP_COMPONENTS),\
      $(foreach &prog,$(call $(&comp).get_programs,$(1)),\
         $(call $(&comp).get_exe_main_obj,$(&prog)))),\
   $(foreach &comp,$(C_EXE_DEP_COMPONENTS),\
      $(call $(&comp).get_obj_files,$(1))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# None
#-------------------------------------------------------------------------------
define c.linker.resolve_exe_static_libs
$(sort \
   $(foreach &comp,$(C_EXE_DEP_COMPONENTS),\
      $(call $(&comp).get_static_libs)))
endef
