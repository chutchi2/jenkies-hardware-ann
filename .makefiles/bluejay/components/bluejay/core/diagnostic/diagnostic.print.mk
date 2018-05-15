#-------------------------------------------------------------------------------
# File: 
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define diagnostic.print

   ifneq ($(strip $(DIAGNOSTICS)),)

      $$(call local_var,diagnostics,$(DIAGNOSTICS))

      ifeq ($(strip $(DIAGNOSTICS)),all)
         diagnostics := \
            global \
            overview \
            $(BLUEJAY_COMPONENT_NAMES) \
            package \
            program
      endif

      $$(call function,diagnostic.print_diagnostics,$$(diagnostics))

   endif

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - diagnostics
#-------------------------------------------------------------------------------
define diagnostic.print_diagnostics

   $(foreach &diag,$(1),\
      $(call function,diagnostic.print_diagnostic,$(&diag)))

   $(info )
   $(info ========================================)
   $(info )

endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - diagnostic
#-------------------------------------------------------------------------------
define diagnostic.print_diagnostic
   ifdef $(1).diagnostic
      $$(info )
      $$(call function,$(1).diagnostic)
   endif
endef
