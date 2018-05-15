#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# $(c.resolve_obj_files)
define c.resolve_obj_files
   $(foreach &pkg,$(C_PACKAGES),\
      $(eval \
         $(call function,c.set_obj_dir,$(&pkg),$(C_OBJ_DIR)/$(&pkg))
         $(foreach &source_file,$(call c.get_source_files,$(&pkg)),\
            $(call function,c.resolve_object_file,$(&pkg),$(&source_file)))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - source file
#-------------------------------------------------------------------------------
define c.resolve_object_file
   $(call local_var,obj_file,$(call c.source_to_object,$(1),$(2)))
   $(call function,c.add_obj_files,$(1),$(obj_file))
   $(obj_file): $(2)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - source files
#-------------------------------------------------------------------------------
define c.source_to_object
$(addprefix $(call c.get_obj_dir,$(1))/,\
   $(addsuffix .$(C_OBJ_EXT),\
      $(foreach &dir,$(call c.get_source_dirs,$(1)),\
         $(patsubst $(&dir)/%,%,$(filter $(&dir)/%,$(2))))))
endef
