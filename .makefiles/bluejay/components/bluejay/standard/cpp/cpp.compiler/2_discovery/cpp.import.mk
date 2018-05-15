#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_package
   $(call local_var,inc_dir,$(PACKAGE_DIR)/$(CPP_PACKAGE_INC_DIR))
   $(call local_var,src_dir,$(PACKAGE_DIR)/$(CPP_PACKAGE_SRC_DIR))

   $(call function,cpp.add_packages,$(PACKAGE),$(src_dir))
   $(call function,cpp.discover_public_includes,$(PACKAGE),$(inc_dir))
   $(call function,cpp.discover_source_files,$(PACKAGE),$(src_dir))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_package_ex
   $(call local_var,inc_dir,$(PACKAGE_DIR)/$(CPP_PACKAGE_INC_DIR))
   $(call local_var,src_dir,$(PACKAGE_DIR)/$(CPP_PACKAGE_SRC_DIR))

   $(call function,cpp.add_packages,$(PACKAGE),$(src_dir))
   $(call function,cpp.__include_extended_pkg,$(PACKAGE),$(inc_dir),$(src_dir),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_dir
   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_public_includes,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_source_files,$(PACKAGE),$(PACKAGE_DIR),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_dir_ex
   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_public_includes_ex,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_source_files_ex,$(PACKAGE),$(PACKAGE_DIR),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list of directories
# $2 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_dirs
   $(call local_var,dirs,$(addprefix $(PACKAGE_DIR)/,$(1)))

   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_public_includes,$(PACKAGE),$(dirs),$(2))
   $(call function,cpp.discover_source_files,$(PACKAGE),$(dirs),$(2))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - list of directories
# $2 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_dirs_ex
   $(call local_var,dirs,$(addprefix $(PACKAGE_DIR)/,$(1)))

   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_public_includes_ex,$(PACKAGE),$(dirs),$(2))
   $(call function,cpp.discover_source_files_ex,$(PACKAGE),$(dirs),$(2))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_private_dir_ex
   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_private_includes_ex,$(PACKAGE),$(PACKAGE_DIR),$(1))
   $(call function,cpp.discover_source_files_ex,$(PACKAGE),$(PACKAGE_DIR),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_source_dir
   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_source_files,$(PACKAGE),$(PACKAGE_DIR),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - exclusion list
#-------------------------------------------------------------------------------
define cpp.import_source_dir_ex
   $(call function,cpp.add_packages,$(PACKAGE),$(PACKAGE_DIR))
   $(call function,cpp.discover_source_files_ex,$(PACKAGE),$(PACKAGE_DIR),$(1))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - filename that contains main
# $2 - program name
#-------------------------------------------------------------------------------
define cpp.import_main

   $(call local_var,program_name,$(2),$(PACKAGE))

   ifneq ($(call global.has_programs,$(program_name)),)
      $$(error Error importing main. Program '$(program_name)' already exists)
   endif

   $(call function,cpp.add_programs,$(PACKAGE),$(program_name))
   $(call function,global.add_programs,$(program_name))

   ifneq ($(strip $(1)),)
      $$(call function,cpp.set_exe_main,$(program_name),$(1))
   endif

endef
