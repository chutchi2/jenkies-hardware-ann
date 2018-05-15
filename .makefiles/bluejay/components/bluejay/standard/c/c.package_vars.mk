#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# $(pkg)_C_PROGRAMS
#
# c.add_programs,$(pkg),$(programs)
# c.get_programs,$(pkg)
# c.get_all_programs
# c.has_programs,$(pkg),$(programs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,c,programs,C_PROGRAMS,C_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_PUBLIC_INCLUDES
#
# c.add_public_includes,$(pkg),$(public_includes)
# c.get_public_includes,$(pkg)
# c.get_all_public_includes
# c.has_public_includes,$(pkg),$(public_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,\
   c,public_includes,C_PUBLIC_INCLUDES,C_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_PRIVATE_INCLUDES
#
# c.add_private_includes,$(pkg),$(private_includes)
# c.get_private_includes,$(pkg)
# c.get_all_private_includes
# c.has_private_includes,$(pkg),$(private_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,\
   c,private_includes,C_PRIVATE_INCLUDES,C_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_SOURCE_DIRS
#
# c.add_source_dirs,$(pkg),$(source_dirs)
# c.get_source_dirs,$(pkg)
# c.get_all_source_dirs
# c.has_source_dirs,$(pkg),$(src_dirs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,c,source_dirs,C_SOURCE_DIRS,C_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_SOURCE_FILES
#
# c.add_source_files,$(pkg),$(source_files)
# c.get_source_files,$(pkg)
# c.get_all_source_files
# c.has_source_files,$(pkg),$(source_files_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,c,source_files,C_SOURCE_FILES,C_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_OBJ_FILES
#
# c.add_obj_files,$(pkg),$(obj_files)
# c.get_obj_files,$(pkg)
# c.get_all_obj_files
# c.has_obj_files,$(pkg),$(obj_files_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,c,obj_files,C_OBJ_FILES,C_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_OBJ_DIR
#
# c.set_obj_dir,$(pkg),$(obj_dir)
# c.get_obj_dir,$(pkg)
# c.get_all_obj_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,obj_dir,C_OBJ_DIR,PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_LIB
#
# c.set_lib,$(pkg),$(lib)
# c.get_lib,$(pkg)
# c.get_all_lib
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,lib,C_LIB,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_C_LIB_DIR
#
# c.set_lib_dir,$(pkg),$(lib_dir)
# c.get_lib_dir,$(pkg)
# c.get_all_lib_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,c,lib_dir,C_LIB_DIR,CPP_PACKAGES)
