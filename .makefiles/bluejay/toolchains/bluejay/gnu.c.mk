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
define c.assemble_flags

   FINAL_C_FLAGS = \
      $$(strip \
         $$(C_FLAGS) \
         $$(addprefix -D,$$(C_DEFINES)) \
         $$(addprefix $$(C_GLOBAL_INCLUDES_FLAG),$$(C_GLOBAL_INCLUDES)) \
         $$(addprefix $$(C_QUOTED_INCLUDES_FLAG),$$(C_QUOTED_INCLUDES)) \
         $$(addprefix $$(C_SYSTEM_INCLUDES_FLAG),$$(C_SYSTEM_INCLUDES)))

endef

#-------------------------------------------------------------------------------
define c.compile_recipe
   $(QUIET)$(C_COMPILER)                          \
      $(FINAL_C_FLAGS)                            \
      -MMD -MF $(@:.$(C_OBJ_EXT)=.$(C_DEP_EXT))   \
      -c $<                                       \
      -o $@
endef

#-------------------------------------------------------------------------------
# Linker
#-------------------------------------------------------------------------------
#-------------------------------------------------------------------------------
define c.linker.assemble_flags

   FINAL_C_LD_FLAGS = $$(strip $$(C_LD_FLAGS))

   FINAL_C_LD_USER_LIBS = $$(strip $$(C_LD_USER_LIBS))

   FINAL_C_LD_LIBS = $$(strip \
      $$(C_LD_LIB_DIRS:%=-L%) \
      $$(C_LD_LIBS:%=-l%))

endef

#-------------------------------------------------------------------------------
define c.linker.link_recipe
   $(QUIET)$(C_LINKER)                                             \
      $(FINAL_C_LD_FLAGS)                                          \
      -Wl,--start-group $^ $(FINAL_C_LD_USER_LIBS) -Wl,--end-group \
      $(FINAL_C_LD_LIBS)                                           \
      -o $@
endef

