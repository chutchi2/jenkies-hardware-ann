#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of header files found in $1
#-------------------------------------------------------------------------------
define cpp.find_header_files
$(call find_files,$(1),$(CPP_HDR_EXTS))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of include paths found in $1
#-------------------------------------------------------------------------------
define cpp.find_includes
$(sort\
   $(call path,\
      $(call cpp.find_header_files,$(1))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of header files found in $1
#-------------------------------------------------------------------------------
define cpp.find_header_files_ex
$(call find_files_ex,$(1),$(CPP_HDR_EXTS))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of include paths found in $1
#-------------------------------------------------------------------------------
define cpp.find_includes_ex
$(call path,\
   $(call cpp.find_header_files_ex,$(1)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - directory
#-------------------------------------------------------------------------------
define cpp.discover_public_includes
   $(call function,cpp.add_public_includes,\
      $(1),\
      $(call cpp.find_includes,$(2)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - directory
#-------------------------------------------------------------------------------
define cpp.discover_public_includes_ex
   $(call function,cpp.add_public_includes,\
      $(1),\
      $(call cpp.find_includes_ex,$(2)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - directory
#-------------------------------------------------------------------------------
define cpp.discover_private_includes_ex
   $(call function,cpp.add_private_includes,\
      $(1),\
      $(call cpp.find_includes_ex,$(2)))
endef
