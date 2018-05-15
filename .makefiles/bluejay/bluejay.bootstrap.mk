#-------------------------------------------------------------------------------
# File: bluejay.bootstrap.mk
#
# Description:
# Initializes the make environment and loads components and toolchains.
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# If -R was not specified on the command line, add the equivalent flags to
# disable the built-in variables and rules.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.disable_builtins)
#-------------------------------------------------------------------------------
define bootstrap.disable_builtins
$(eval 
   ifeq ($(findstring R,$(MAKEFLAGS)),)
      MAKEFLAGS += --no-builtin-rules --no-builtin-variables
   endif
)
endef

#-------------------------------------------------------------------------------
# Explicitly define the default goal.
#
# If the default goal is not explicitly defined, make uses the first target it
# comes across.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.assign_default_goal)
#-------------------------------------------------------------------------------
define bootstrap.assign_default_goal
$(eval 
   .DEFAULT_GOAL := $(BLUEJAY_DEFAULT_GOAL)
)
endef

#-------------------------------------------------------------------------------
# Assign variables used for display based on command line usage.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.assign_display_vars)
#-------------------------------------------------------------------------------
define bootstrap.assign_display_vars
$(eval 
   ifndef VERBOSE
      QUIET := @
   endif

   ifeq ($(VERBOSE),d)
      SHOW_DEPS = $$(cle.show_dependencies)
   endif
)
endef

#-------------------------------------------------------------------------------
# Include makefiles specific to the bluejay framework.
#
# Arguments:
# $1 - makefiles to include
#
# Usage:
# $(call bootstrap.include_makefiles,$1)
#-------------------------------------------------------------------------------
define bootstrap.include_makefiles
$(eval 
   include $(addprefix $(BLUEJAY_HOME_DIR)/,$(1))
)
endef

#-------------------------------------------------------------------------------
# Include makefiles specific to a component of the bluejay framework.
#
# Arguments:
# $1 - fully qualified component
# $2 - makefiles to include
#
# Usage:
# $(call bootstrap.include_component_makefiles,$1,$2)
#-------------------------------------------------------------------------------
define bootstrap.include_component_makefiles
$(eval 
   include $(addprefix $(BLUEJAY_HOME_DIR)/$(BLUEJAY_COMPONENT_DIR)/$(1)/,$(2))
)
endef

#-------------------------------------------------------------------------------
# Import defaults.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.import_defaults)
#-------------------------------------------------------------------------------
define bootstrap.import_defaults
$(eval 
   $(call bootstrap.include_makefiles,\
      $(patsubst %,$(BLUEJAY_DEFAULTS_DIR)/%.mk,$(BLUEJAY_DEFAULTS)))
)
endef

#-------------------------------------------------------------------------------
# Import components.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.import_components)
#-------------------------------------------------------------------------------
define bootstrap.import_components
$(eval 
   $(foreach &comp,bluejay/core $(BLUEJAY_COMPONENTS),\
      $(call \
         bootstrap.include_component_makefiles,$(&comp),$(notdir $(&comp)).mk))
)
endef

#-------------------------------------------------------------------------------
# Import toolchains.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.import_toolchains)
#-------------------------------------------------------------------------------
define bootstrap.import_toolchains
$(eval 
   $(call bootstrap.include_makefiles,\
      $(patsubst %,$(BLUEJAY_TOOLCHAIN_DIR)/%.mk,$(BLUEJAY_TOOLCHAINS)))
)
endef

#-------------------------------------------------------------------------------
# Execute the bootstrap process.
#
# Arguments:
# None
#
# Usage:
# $(call bootstrap.load)
#-------------------------------------------------------------------------------
define bootstrap.load
$(eval 
   $(call bootstrap.disable_builtins)
   $(call bootstrap.assign_default_goal)
   $(call bootstrap.assign_display_vars)
   $(call bootstrap.import_defaults)
   $(call bootstrap.import_components)
   $(call bootstrap.import_toolchains)
)
endef

#-------------------------------------------------------------------------------
$(call bootstrap.load)
