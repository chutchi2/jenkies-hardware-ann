#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# None
#-------------------------------------------------------------------------------
define cpp.compiler.diagnostic
   $(call function,print_component_header,cpp)

   $(call local_var,CPP_OBJECTS,$(call cpp.get_all_obj_files))

   $(call local_var,list,\
      CPP_GLOBAL_INCLUDES \
      CPP_QUOTED_INCLUDES \
      CPP_SYSTEM_INCLUDES \
      CPP_OBJECTS \
      CPP_STATIC_LIBS \
      CPP_SECONDARY_STATIC_LIBS \
      CPP_PACKAGES)

   $(call function,print_lists,$(list))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define cpp.compiler.package.diagnostic

   ifneq ($(call cpp.has_packages,$(1)),)

      $$(call function,print_component_subheader,cpp)

      $$(info $(1)_CPP_LIB      : $($(1)_CPP_LIB))
      $$(info $(1)_CPP_LIB_DIR  : $($(1)_CPP_LIB_DIR))
      $$(info $(1)_CPP_OBJ_DIR  : $($(1)_CPP_OBJ_DIR))

      $$(call local_var,list,\
         $(1)_CPP_PROGRAMS \
         $(1)_CPP_PUBLIC_INCLUDES \
         $(1)_CPP_PRIVATE_INCLUDES \
         $(1)_CPP_SOURCE_DIRS \
         $(1)_CPP_OBJ_FILES \
         $(1)_CPP_SOURCE_FILES)

      $$(call function,print_lists,$$(list))

   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - program
#-------------------------------------------------------------------------------
define cpp.compiler.program.diagnostic
   ifneq ($(call cpp.get_exe,$(1)),)
      $$(call function,print_header,Program: $(1))
      $$(info $(1)_CPP_EXE           : $($(1)_CPP_EXE))
      $$(info $(1)_CPP_EXE_DIR       : $($(1)_CPP_EXE_DIR))
      $$(info )
      $$(info $(1)_CPP_EXE_PKG       : $($(1)_CPP_EXE_PKG))
      $$(info $(1)_CPP_EXE_MAIN      : $($(1)_CPP_EXE_MAIN))
      $$(info $(1)_CPP_EXE_MAIN_OBJ  : $($(1)_CPP_EXE_MAIN_OBJ))
      $$(call function,print_list,$(1)_CPP_EXE_DEPS)
   endif
endef
