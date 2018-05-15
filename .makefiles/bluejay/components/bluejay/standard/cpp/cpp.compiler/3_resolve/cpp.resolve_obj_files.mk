#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# $(cpp.resolve_obj_files)
define cpp.resolve_obj_files
   $(foreach &pkg,$(CPP_PACKAGES),\
      $(eval \
         $(call function,cpp.set_obj_dir,$(&pkg),$(CPP_OBJ_DIR)/$(&pkg))
         $(foreach &source_file,$(call cpp.get_source_files,$(&pkg)),\
            $(call function,cpp.resolve_object_file,$(&pkg),$(&source_file)))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - source file
#-------------------------------------------------------------------------------
define cpp.resolve_object_file
   $(call local_var,obj_file,$(call cpp.source_to_object,$(1),$(2)))
   $(call function,cpp.add_obj_files,$(1),$(obj_file))
   $(obj_file): $(2)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - source files
#-------------------------------------------------------------------------------
define cpp.source_to_object
$(addprefix $(call cpp.get_obj_dir,$(1))/,\
   $(addsuffix .$(CPP_OBJ_EXT),\
      $(foreach &dir,$(call cpp.get_source_dirs,$(1)),\
         $(patsubst $(&dir)/%,%,$(filter $(&dir)/%,$(2))))))
endef
