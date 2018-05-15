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
define cpp.__include_extended_pkg

   $(call local_var,cpp_hdrs)
   $(call local_var,cpp_include_dirs)
   $(call local_var,cpp_dirs)

   #----------------------------------------------------------------------------
   # Auto include public include directory
   #----------------------------------------------------------------------------
   $(eval cpp_hdrs := $(call cpp.find_header_files_recursively,$(2)))

   ifneq ($(strip $(cpp_hdrs)),)
      $$(call function,cpp.add_public_includes,$(1),$(2))
   endif

   #----------------------------------------------------------------------------
   # Add source files
   #----------------------------------------------------------------------------
   $$(call function,cpp.auto_update_source_files_ex,$(1),$(3),$(4))

   #----------------------------------------------------------------------------
   # Auto include private include dirs
   #----------------------------------------------------------------------------
   $(eval cpp_hdrs := $(call cpp.find_header_files_recursively,$(3)))
   $(eval cpp_include_dirs := \
      $(sort $(filter %/$(CPP_PACKAGE_INC_DIR),$(call path,$(cpp_hdrs)))))

   ifneq ($(strip $(cpp_include_dirs)),)
      $$(call function,cpp.add_private_includes,$(1),$(cpp_include_dirs))
   endif

   #----------------------------------------------------------------------------
   # Auto include the source dir
   # If there is at least one hpp or cpp file in any subdirectory and an hpp
   # file exists in the src dir
   #
   # FIXME: cpp_files not defined in this function.
   #----------------------------------------------------------------------------
   $(eval cpp_dirs := \
      $(sort \
         $(filter-out $(3),\
            $(call path,$(cpp_hdrs) $(cpp_files)))))

   ifneq ($(strip $(cpp_dirs)),)

      cpp_hdrs := $$(call cpp.find_header_files,$(3))
      
      ifneq ($$(strip $$(cpp_hdrs)),)
         $$(call function,cpp.add_private_includes,$(1),$(3))
      endif

   endif

endef
