#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# C_PACKAGES
#
# c.add_packages,$(pkg)
# c.get_packages
# c.has_packages,$(pkgs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,c,packages,C_PACKAGES)

#-------------------------------------------------------------------------------
# Override default c.add_packages function.
#
# Arguments:
# $1 - package
# $2 - package source directory
#-------------------------------------------------------------------------------
define c.add_packages
   $(call function,sorted_list.add,C_PACKAGES,$(1))
   $(call function,c.add_source_dirs,$(1),$(2))
endef

#-------------------------------------------------------------------------------
# C_PROGRAMS
#
#-------------------------------------------------------------------------------
define C_PROGRAMS
$(call c.get_all_programs)
endef

#-------------------------------------------------------------------------------
# C_STATIC_LIBS
#
# c.add_static_libs,$(static_libs)
# c.get_static_libs
# c.has_static_libs,$(static_libs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,c,static_libs,C_STATIC_LIBS)

#-------------------------------------------------------------------------------
# C_SECONDARY_STATIC_LIBS
#
# c.add_secondary_static_libs,$(secondary_static_libs)
# c.get_secondary_static_libs
# c.has_secondary_static_libs,$(secondary_static_libs_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,c,secondary_static_libs,C_SECONDARY_STATIC_LIBS)

#-------------------------------------------------------------------------------
# C_GLOBAL_INCLUDES
#
# c.add_global_includes,$(global_includes)
# c.get_global_includes
# c.has_global_includes,$(global_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,c,global_includes,C_GLOBAL_INCLUDES)

#-------------------------------------------------------------------------------
# C_QUOTED_INCLUDES
#
# c.add_quoted_includes,$(quoted_includes)
# c.get_quoted_includes
# c.has_quoted_includes,$(quoted_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,c,quoted_includes,C_QUOTED_INCLUDES)

#-------------------------------------------------------------------------------
# C_SYSTEM_INCLUDES
#
# c.add_system_includes,$(system_includes)
# c.get_system_includes
# c.has_system_includes,$(system_includes_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_sorted_list,c,system_includes,C_SYSTEM_INCLUDES)
