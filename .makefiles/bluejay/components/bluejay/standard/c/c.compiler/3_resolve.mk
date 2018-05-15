#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.compiler.stage_3

   $(call function,c.resolve_obj_files)
   $(call function,c.resolve_mains)
   $(call function,c.include_dependency_files)
   $(call function,c.resolve_quoted_includes)

   $(foreach &pkg,$(C_PACKAGES),\
      $(call function,c.resolve_private_includes,$(&pkg)))

   $(call local_var,build_dirs)
   build_dirs := \
      $(sort $(call path,$(call c.get_all_obj_files))\
      $(C_OBJ_DIR))

   $$(call function,build_tree.add_build_directories,$$(build_dirs))

endef

#-------------------------------------------------------------------------------
# $(c.include_dependency_files)
define c.include_dependency_files
   ifeq ($(strip $(findstring clean,$(MAKECMDGOALS))),)
      -include \
         $(patsubst %.$(C_OBJ_EXT),%.$(C_DEP_EXT),\
            $(call c.get_all_obj_files))
   endif
endef

#-------------------------------------------------------------------------------
# Arguments:
# None
#-------------------------------------------------------------------------------
define c.resolve_quoted_includes
   $(foreach &comp,$(C_INCLUDE_COMPONENTS),\
      $(call function,c.add_quoted_includes,\
         $(call $(&comp).get_all_public_includes)))
endef

#-------------------------------------------------------------------------------
# Note: c.resolve_quoted_includes must be called before this method.
#
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define c.resolve_private_includes

   $(call local_var,private_includes,\
      $(foreach &comp,$(C_INCLUDE_COMPONENTS),\
         $(call $(&comp).get_private_includes,$(1))))

   ifneq ($(strip $(private_includes)),)
      $$(call c.get_obj_files,$(1)):\
         C_QUOTED_INCLUDES := $$(strip $$(private_includes) $$(C_QUOTED_INCLUDES))
   endif

endef
