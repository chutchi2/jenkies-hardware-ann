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
define c.find_header_files
$(call find_files,$(1),$(C_HDR_EXTS))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of include paths found in $1
#-------------------------------------------------------------------------------
define c.find_includes
$(sort\
   $(call path,\
      $(call c.find_header_files,$(1))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of header files found in $1
#-------------------------------------------------------------------------------
define c.find_header_files_ex
$(call find_files_ex,$(1),$(C_HDR_EXTS))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - directory
#
# Returns:
# List of include paths found in $1
#-------------------------------------------------------------------------------
define c.find_includes_ex
$(call path,\
   $(call c.find_header_files_ex,$(1)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - directory
#-------------------------------------------------------------------------------
define c.discover_public_includes
   $(call function,c.add_public_includes,\
      $(1),\
      $(call c.find_includes,$(2)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - directory
#-------------------------------------------------------------------------------
define c.discover_public_includes_ex
   $(call function,c.add_public_includes,\
      $(1),\
      $(call c.find_includes_ex,$(2)))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - directory
#-------------------------------------------------------------------------------
define c.discover_private_includes_ex
   $(call function,c.add_private_includes,\
      $(1),\
      $(call c.find_includes_ex,$(2)))
endef
