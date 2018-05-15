#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# BUILD_DIRS
#
# build_tree.add_build_directories,$(build_directories)
# cpp.get_build_directories
# cpp.has_build_directories,$(build_directories_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,build_tree,build_directories,BUILD_DIRS)

#-------------------------------------------------------------------------------
# CLEAN_DIRS
#
# build_tree.add_clean_directories,$(clean_directories)
# cpp.get_clean_directories
# cpp.has_clean_directories,$(clean_directories_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,build_tree,clean_directories,CLEAN_DIRS)
