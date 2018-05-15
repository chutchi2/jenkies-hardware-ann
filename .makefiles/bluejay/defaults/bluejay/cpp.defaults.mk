#-------------------------------------------------------------------------------
# File: cpp.defaults.mk
#
# Description:
# Defines default values for variables used by the standard cpp build stack.
#
# * Variables defined in this file can be overriden by defining them AFTER
#   including bluejay.mk.
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# File Extensions
#-------------------------------------------------------------------------------
CPP_HDR_EXTS  := hpp hh
CPP_FILE_EXTS := cpp cc

CPP_DEP_EXT   := $(DEP_EXT)
CPP_OBJ_EXT   := $(OBJ_EXT)
CPP_LIB_EXT   := $(LIB_EXT)
CPP_EXE_EXT   := $(EXE_EXT)

#-------------------------------------------------------------------------------
# File Names
#-------------------------------------------------------------------------------
CPP_FLAGS_FILE    := cpp.flags.mk
CPP_LD_FLAGS_FILE := cpp.ld.flags.mk

CPP_DEFAULT_MAIN  := $(DEFAULT_MAIN)

#-------------------------------------------------------------------------------
# Directory Names
#-------------------------------------------------------------------------------
CPP_PACKAGE_INC_DIR := $(PACKAGE_INC_DIR)
CPP_PACKAGE_SRC_DIR := $(PACKAGE_SRC_DIR)

#-------------------------------------------------------------------------------
# Directory Paths
#-------------------------------------------------------------------------------
CPP_OBJ_DIR := $(OBJ_DIR)
CPP_LIB_DIR := $(LIB_DIR)
CPP_EXE_DIR := $(EXE_DIR)

#-------------------------------------------------------------------------------
# Indpendent Mode
#-------------------------------------------------------------------------------
CPP_EXE_DEP_COMPONENTS := cpp
CPP_PROGRAM_COMPONENTS := cpp
CPP_INCLUDE_COMPONENTS := cpp

#-------------------------------------------------------------------------------
# Integrated Mode
#-------------------------------------------------------------------------------
#CPP_EXE_DEP_COMPONENTS := cpp c
#CPP_PROGRAM_COMPONENTS := cpp c
#CPP_INCLUDE_COMPONENTS := cpp c
