#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.compiler.stage_3

   $(call function,cpp.resolve_obj_files)
   $(call function,cpp.resolve_mains)
   $(call function,cpp.include_dependency_files)
   $(call function,cpp.resolve_quoted_includes)

   $(foreach &pkg,$(CPP_PACKAGES),\
      $(call function,cpp.resolve_private_includes,$(&pkg)))

   $(call local_var,build_dirs)
   build_dirs := \
      $(sort $(call path,$(call cpp.get_all_obj_files))\
      $(CPP_OBJ_DIR))

   $$(call function,build_tree.add_build_directories,$$(build_dirs))

endef

#-------------------------------------------------------------------------------
# $(cpp.include_dependency_files)
define cpp.include_dependency_files
   ifeq ($(strip $(findstring clean,$(MAKECMDGOALS))),)
      -include \
         $(patsubst %.$(CPP_OBJ_EXT),%.$(CPP_DEP_EXT),\
            $(call cpp.get_all_obj_files))
   endif
endef

#-------------------------------------------------------------------------------
# Arguments:
# None
#-------------------------------------------------------------------------------
define cpp.resolve_quoted_includes
   $(foreach &comp,$(CPP_INCLUDE_COMPONENTS),\
      $(call function,cpp.add_quoted_includes,\
         $(call $(&comp).get_all_public_includes)))
endef

#-------------------------------------------------------------------------------
# Note: cpp.resolve_quoted_includes must be called before this method.
#
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define cpp.resolve_private_includes

   $(call local_var,private_includes,\
      $(foreach &comp,$(CPP_INCLUDE_COMPONENTS),\
         $(call $(&comp).get_private_includes,$(1))))

   ifneq ($(strip $(private_includes)),)
      $$(call cpp.get_obj_files,$(1)):\
         CPP_QUOTED_INCLUDES := $$(strip $$(private_includes) $$(CPP_QUOTED_INCLUDES))
   endif

endef
