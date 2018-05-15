#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
# $2 - include directory
# $3 - source directory
# $4 - exclusion list
#-------------------------------------------------------------------------------
define c.__include_extended_pkg

   $(call local_var,c_hdrs)
   $(call local_var,c_include_dirs)
   $(call local_var,c_dirs)

   #----------------------------------------------------------------------------
   # Auto include public include directory
   #----------------------------------------------------------------------------
   $(eval c_hdrs := $(call c.find_header_files_recursively,$(2)))

   ifneq ($(strip $(c_hdrs)),)
      $$(call function,c.add_public_includes,$(1),$(2))
   endif

   #----------------------------------------------------------------------------
   # Add source files
   #----------------------------------------------------------------------------
   $$(call function,c.auto_update_source_files_ex,$(1),$(3),$(4))

   #----------------------------------------------------------------------------
   # Auto include private include dirs
   #----------------------------------------------------------------------------
   $(eval c_hdrs := $(call c.find_header_files_recursively,$(3)))
   $(eval c_include_dirs := \
      $(sort $(filter %/$(C_PACKAGE_INC_DIR),$(call path,$(c_hdrs)))))

   ifneq ($(strip $(c_include_dirs)),)
      $$(call function,c.add_private_includes,$(1),$(c_include_dirs))
   endif

   #----------------------------------------------------------------------------
   # Auto include the source dir
   # If there is at least one hpp or c file in any subdirectory and an hpp
   # file exists in the src dir
   #
   # FIXME: c_files not defined in this function.
   #----------------------------------------------------------------------------
   $(eval c_dirs := \
      $(sort \
         $(filter-out $(3),\
            $(call path,$(c_hdrs) $(c_files)))))

   ifneq ($(strip $(c_dirs)),)

      c_hdrs := $$(call c.find_header_files,$(3))
      
      ifneq ($$(strip $$(c_hdrs)),)
         $$(call function,c.add_private_includes,$(1),$(3))
      endif

   endif

endef
