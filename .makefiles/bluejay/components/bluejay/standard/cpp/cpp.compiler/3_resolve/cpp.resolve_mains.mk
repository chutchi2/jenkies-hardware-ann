#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.resolve_mains

   $(foreach &pkg,$(CPP_PACKAGES),\
      $(foreach &prog,$(call cpp.get_programs,$(&pkg)),\
         $(call function,cpp.resolve_main,$(&pkg),$(&prog))))

endef

#-------------------------------------------------------------------------------
# Performs a right-most match, same as exclusion lists.
#
# Arguments:
# $1 - package
# $2 - filename
# $3 - source files
#
# Reutrns:
# source file
#-------------------------------------------------------------------------------
define cpp.find_main_source_file
$(filter $(addprefix %,$(2)),$(3))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - source files
#
# Reutrns:
# source file
#-------------------------------------------------------------------------------
define cpp.find_main
$(strip\
   $(filter\
      $(foreach &main,$(CPP_DEFAULT_MAIN),\
         $(addprefix %$(&main).,$(CPP_FILE_EXTS))),$(1)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - program
#-------------------------------------------------------------------------------
define cpp.resolve_main
   $(call function,cpp.resolve_exe_main,$(1),$(2))
   $(call function,cpp.resolve_exe_main_obj,$(1),$(2))
   $(call function,cpp.set_exe_pkg,$(2),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - program
#-------------------------------------------------------------------------------
define cpp.resolve_exe_main

   $(call local_var,exe_main)
   $(call local_var,main_source_file,$(call cpp.get_exe_main,$(2)))
   $(call local_var,source_files,$(call cpp.get_source_files,$(1)))

   ifeq ($(main_source_file),)
      exe_main := $$(call cpp.find_main,$$(source_files))
   else
      exe_main := \
         $$(call cpp.find_main_source_file,$(1),$$(main_source_file),$$(source_files))
   endif

   ifeq ($$(exe_main),)
      $$(error Could not find main $$(if $$(main_source_file),[$$(main_source_file)] ,)in package '$(1)' for program '$(2)')
   else ifneq ($$(words $$(exe_main)),1)
      $$(error Multiple mains found $$(if $$(exe_main),[$$(exe_main)] ,)in package '$(1)' for program '$(2)')
   endif

   $$(call function,cpp.set_exe_main,$(2),$$(exe_main))

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - program
#-------------------------------------------------------------------------------
define cpp.resolve_exe_main_obj

   $(call local_var,exe_main,$(call cpp.get_exe_main,$(2)))
   $(call local_var,exe_main_obj,$(call cpp.source_to_object,$(1),$(exe_main)))

   ifeq ($(call cpp.has_obj_files,$(1),$(exe_main_obj)),)
      $$(error Could not find main [$$(exe_main_obj)] in package '$(1)' for program '$(2)')
   endif

   $$(call function,cpp.set_exe_main_obj,$(2),$$(exe_main_obj))

endef
