#-------------------------------------------------------------------------------
# Filename: twig.local_var.scope.mk
#
# Description:
# Implements local variable scope.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Arguments:
# $1 - scope
#
# Returns:
#
# Usage:
# $(call twig.local_var.scope.get_list_name,$1)
#-------------------------------------------------------------------------------
__get_list_name__ = $(call twig.local_var.scope.get_list_name,$(1))

define twig.local_var.scope.get_list_name
__$(1)_local_vars__
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - scope
# $2 - variable name
#
# Usage:
# $(call twig.local_var.scope.add_var,$1,$2)
#-------------------------------------------------------------------------------
define twig.local_var.scope.add_var
$(eval 
   
   ifneq ($(call twig.sorted_list.find,$(__get_list_name__),$(2)),)
      $$(warning $(0): [Scope: $(1), Variable: $(2)] Variable already defined in this scope.)
   else
      $$(call twig.sorted_list.add,$$(__get_list_name__),$(2))

      ifndef $$(call twig.local_var.value_stack.get_stack_name,$(2))
         ifndef $(2)
            $$(call twig.local_var.value_stack.push_value,$(2),__<EOS>__)
         else
            $$(call twig.local_var.value_stack.push_value,$(2))
         endif
      else
         $$(call twig.local_var.value_stack.push_value,$(2))
      endif
   endif

)
endef

#-------------------------------------------------------------------------------
# Arguments:
# $1 - scope
#
# Usage:
# $(call twig.local_var.scope.clear,$1)
#-------------------------------------------------------------------------------
define twig.local_var.scope.clear
$(eval 
   $(foreach var,$($(__get_list_name__)),\
      $(eval 
         $(call twig.local_var.value_stack.pop_value,$(var))

         ifeq ($($(var)),__<EOS>__)
            $$(call twig.undefine,$(var))
         endif
      ))

   $(call twig.undefine,$(__get_list_name__))
)
endef
