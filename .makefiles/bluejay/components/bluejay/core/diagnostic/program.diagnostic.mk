#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define program.diagnostic
   $(call function,print_header,$ $ $ $ $ $ $ $ $ ***** PROGRAMS *****)
   $(foreach &prog,$(PROGRAMS),\
      $(eval \
         $(if $(filter $(firstword $(PROGRAMS)),$(&prog)),,$(info )) \
         $(call function,print_program_diagnostic,$(&prog))))
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - program
#-------------------------------------------------------------------------------
define print_program_diagnostic
   $(foreach &comp,$(BLUEJAY_COMPONENT_NAMES),\
      $(call try_function,$(&comp).program.diagnostic,$(1)))
endef
