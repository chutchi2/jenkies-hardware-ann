#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# CPP_PACKAGES
#
# cpp.add_packages,$(pkg)
# cpp.get_packages
# cpp.has_packages,$(pkgs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,packages,CPP_PACKAGES)

#-------------------------------------------------------------------------------
# Override default cpp.add_packages function.
#
# Arguments:
# $1 - package
# $2 - package source directory
#-------------------------------------------------------------------------------
define cpp.add_packages
   $(call function,sorted_list.add,CPP_PACKAGES,$(1))
   $(call function,cpp.add_source_dirs,$(1),$(2))
endef

#-------------------------------------------------------------------------------
# CPP_PROGRAMS
#
#-------------------------------------------------------------------------------
define CPP_PROGRAMS
$(call cpp.get_all_programs)
endef

#-------------------------------------------------------------------------------
# CPP_STATIC_LIBS
#
# cpp.add_static_libs,$(static_libs)
# cpp.get_static_libs
# cpp.has_static_libs,$(static_libs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,static_libs,CPP_STATIC_LIBS)

#-------------------------------------------------------------------------------
# CPP_SECONDARY_STATIC_LIBS
#
# cpp.add_secondary_static_libs,$(secondary_static_libs)
# cpp.get_secondary_static_libs
# cpp.has_secondary_static_libs,$(secondary_static_libs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,secondary_static_libs,CPP_SECONDARY_STATIC_LIBS)

#-------------------------------------------------------------------------------
# CPP_GLOBAL_INCLUDES
#
# cpp.add_global_includes,$(global_includes)
# cpp.get_global_includes
# cpp.has_global_includes,$(global_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,global_includes,CPP_GLOBAL_INCLUDES)

#-------------------------------------------------------------------------------
# CPP_QUOTED_INCLUDES
#
# cpp.add_quoted_includes,$(quoted_includes)
# cpp.get_quoted_includes
# cpp.has_quoted_includes,$(quoted_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,quoted_includes,CPP_QUOTED_INCLUDES)

#-------------------------------------------------------------------------------
# CPP_SYSTEM_INCLUDES
#
# cpp.add_system_includes,$(system_includes)
# cpp.get_system_includes
# cpp.has_system_includes,$(system_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,cpp,system_includes,CPP_SYSTEM_INCLUDES)
