#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Compiler
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.assemble_flags

   FINAL_CPP_FLAGS = \
      $$(strip \
         $$(CPP_FLAGS) \
         $$(addprefix -D,$$(CPP_DEFINES)) \
         $$(addprefix $$(CPP_GLOBAL_INCLUDES_FLAG),$$(CPP_GLOBAL_INCLUDES)) \
         $$(addprefix $$(CPP_QUOTED_INCLUDES_FLAG),$$(CPP_QUOTED_INCLUDES)) \
         $$(addprefix $$(CPP_SYSTEM_INCLUDES_FLAG),$$(CPP_SYSTEM_INCLUDES)))

endef

#-------------------------------------------------------------------------------
define cpp.compile_recipe
   $(QUIET)$(CPP_COMPILER)                          \
      $(FINAL_CPP_FLAGS)                            \
      -MMD -MF $(@:.$(CPP_OBJ_EXT)=.$(CPP_DEP_EXT)) \
      -c $<                                         \
      -o $@
endef

#-------------------------------------------------------------------------------
# Linker
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.linker.assemble_flags

   FINAL_CPP_LD_FLAGS = $$(strip $$(CPP_LD_FLAGS))

   FINAL_CPP_LD_USER_LIBS = $$(strip $$(CPP_LD_USER_LIBS))

   FINAL_CPP_LD_LIBS = $$(strip \
      $$(CPP_LD_LIB_DIRS:%=-L%) \
      $$(CPP_LD_LIBS:%=-l%))

endef

#-------------------------------------------------------------------------------
define cpp.linker.link_recipe
   $(QUIET)$(CPP_LINKER)                                             \
      $(FINAL_CPP_LD_FLAGS)                                          \
      -Wl,--start-group $^ $(FINAL_CPP_LD_USER_LIBS) -Wl,--end-group \
      $(FINAL_CPP_LD_LIBS)                                           \
      -o $@
endef

