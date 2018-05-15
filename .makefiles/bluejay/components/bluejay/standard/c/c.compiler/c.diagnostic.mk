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
define c.compiler.diagnostic
   $(call function,print_component_header,c)

   $(call local_var,C_OBJECTS,$(call c.get_all_obj_files))

   $(call local_var,list,\
      C_GLOBAL_INCLUDES \
      C_QUOTED_INCLUDES \
      C_SYSTEM_INCLUDES \
      C_OBJECTS \
      C_STATIC_LIBS \
      C_SECONDARY_STATIC_LIBS \
      C_PACKAGES)

   $(call function,print_lists,$(list))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - package
#-------------------------------------------------------------------------------
define c.compiler.package.diagnostic

   ifneq ($(call c.has_packages,$(1)),)

      $$(call function,print_component_subheader,c)

      $$(info $(1)_C_LIB      : $($(1)_C_LIB))
      $$(info $(1)_C_LIB_DIR  : $($(1)_C_LIB_DIR))
      $$(info $(1)_C_OBJ_DIR  : $($(1)_C_OBJ_DIR))

      $$(call local_var,list,\
         $(1)_C_PROGRAMS \
         $(1)_C_PUBLIC_INCLUDES \
         $(1)_C_PRIVATE_INCLUDES \
         $(1)_C_SOURCE_DIRS \
         $(1)_C_OBJ_FILES \
         $(1)_C_SOURCE_FILES)

      $$(call function,print_lists,$$(list))

   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - program
#-------------------------------------------------------------------------------
define c.compiler.program.diagnostic
   ifneq ($(call c.get_exe,$(1)),)
      $$(call function,print_header,Program: $(1))
      $$(info $(1)_C_EXE           : $($(1)_C_EXE))
      $$(info $(1)_C_EXE_DIR       : $($(1)_C_EXE_DIR))
      $$(info )
      $$(info $(1)_C_EXE_PKG       : $($(1)_C_EXE_PKG))
      $$(info $(1)_C_EXE_MAIN      : $($(1)_C_EXE_MAIN))
      $$(info $(1)_C_EXE_MAIN_OBJ  : $($(1)_C_EXE_MAIN_OBJ))
      $$(call function,print_list,$(1)_C_EXE_DEPS)
   endif
endef
