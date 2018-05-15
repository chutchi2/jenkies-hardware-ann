#-------------------------------------------------------------------------------
# Filename: makefile
#
# Description:
# This makefile is for convenience only. It allows make commands to be used to
# perform builds in multiple subdirectories.
#
# Usage:
# make [build_dir...] [clean] [make_flags]
#-------------------------------------------------------------------------------
# Define goals
BUILD_DIRS         := debug release
PASS_THROUGH_GOALS := clean

# Break down the goals passed in on the command line
PASS_THROUGH_CMD_GOALS := $(filter $(PASS_THROUGH_GOALS),$(MAKECMDGOALS))
REMAINING_CMD_GOALS    := $(filter-out $(PASS_THROUGH_GOALS),$(MAKECMDGOALS))

# Define dependencies for goals that are passed through to the build directories
ifeq ($(REMAINING_CMD_GOALS),)
PASS_THROUGH_DEPS := $(BUILD_DIRS)
else
PASS_THROUGH_DEPS :=
endif

# Define default target
all: $(BUILD_DIRS)

# Make settings
.PHONY: $(PASS_THROUGH_GOALS) $(BUILD_DIRS) all
.SUFFIXES:
makefile: ;

# Rules
$(BUILD_DIRS):
ifeq ($(strip $(findstring clean,$(PASS_THROUGH_CMD_GOALS))),)
	@echo ========== Building $@
else
	@echo ========== Cleaning $@
endif
	@$(MAKE) -C $@ --no-print-directory $(PASS_THROUGH_CMD_GOALS)
	@echo

$(PASS_THROUGH_GOALS): $(PASS_THROUGH_DEPS)
	@cd # effectively a no op needed to prevent make from saying there is nothing to be done
