#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# $(pkg)_CPP_PROGRAMS
#
# cpp.add_programs,$(pkg),$(programs)
# cpp.get_programs,$(pkg)
# cpp.get_all_programs
# cpp.has_programs,$(pkg),$(programs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,cpp,programs,CPP_PROGRAMS,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_PUBLIC_INCLUDES
#
# cpp.add_public_includes,$(pkg),$(public_includes)
# cpp.get_public_includes,$(pkg)
# cpp.get_all_public_includes
# cpp.has_public_includes,$(pkg),$(public_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,\
   cpp,public_includes,CPP_PUBLIC_INCLUDES,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_PRIVATE_INCLUDES
#
# cpp.add_private_includes,$(pkg),$(private_includes)
# cpp.get_private_includes,$(pkg)
# cpp.get_all_private_includes
# cpp.has_private_includes,$(pkg),$(private_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,\
   cpp,private_includes,CPP_PRIVATE_INCLUDES,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_SOURCE_DIRS
#
# cpp.add_source_dirs,$(pkg),$(source_dirs)
# cpp.get_source_dirs,$(pkg)
# cpp.get_all_source_dirs
# cpp.has_source_dirs,$(pkg),$(src_dirs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,cpp,source_dirs,CPP_SOURCE_DIRS,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_SOURCE_FILES
#
# cpp.add_source_files,$(pkg),$(source_files)
# cpp.get_source_files,$(pkg)
# cpp.get_all_source_files
# cpp.has_source_files,$(pkg),$(source_files_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,cpp,source_files,CPP_SOURCE_FILES,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_OBJ_FILES
#
# cpp.add_obj_files,$(pkg),$(obj_files)
# cpp.get_obj_files,$(pkg)
# cpp.get_all_obj_files
# cpp.has_obj_files,$(pkg),$(obj_files_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_pkg_list,cpp,obj_files,CPP_OBJ_FILES,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_OBJ_DIR
#
# cpp.set_obj_dir,$(pkg),$(obj_dir)
# cpp.get_obj_dir,$(pkg)
# cpp.get_all_obj_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,obj_dir,CPP_OBJ_DIR,PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_LIB
#
# cpp.set_lib,$(pkg),$(lib)
# cpp.get_lib,$(pkg)
# cpp.get_all_lib
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,lib,CPP_LIB,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# $(pkg)_CPP_LIB_DIR
#
# cpp.set_lib_dir,$(pkg),$(lib_dir)
# cpp.get_lib_dir,$(pkg)
# cpp.get_all_lib_dir
#-------------------------------------------------------------------------------
$(call function,declare_pkg_var,cpp,lib_dir,CPP_LIB_DIR,CPP_PACKAGES)
