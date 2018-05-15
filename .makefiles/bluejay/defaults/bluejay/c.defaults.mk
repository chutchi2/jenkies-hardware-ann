#-------------------------------------------------------------------------------
# File: c.defaults.mk
#
# Description:
# Defines default values for variables used by the standard c build stack.
#
# * Variables defined in this file can be overriden by defining them AFTER
#   including bluejay.mk.
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# File Extensions
#-------------------------------------------------------------------------------
C_HDR_EXTS  := h
C_FILE_EXTS := c

C_DEP_EXT   := $(DEP_EXT)
C_OBJ_EXT   := $(OBJ_EXT)
C_LIB_EXT   := $(LIB_EXT)
C_EXE_EXT   := $(EXE_EXT)

#-------------------------------------------------------------------------------
# File Names
#-------------------------------------------------------------------------------
C_FLAGS_FILE    := c.flags.mk
C_LD_FLAGS_FILE := c.ld.flags.mk

C_DEFAULT_MAIN  := $(DEFAULT_MAIN)

#-------------------------------------------------------------------------------
# Directory Names
#-------------------------------------------------------------------------------
C_PACKAGE_INC_DIR := $(PACKAGE_INC_DIR)
C_PACKAGE_SRC_DIR := $(PACKAGE_SRC_DIR)

#-------------------------------------------------------------------------------
# Directory Paths
#-------------------------------------------------------------------------------
C_OBJ_DIR := $(OBJ_DIR)
C_LIB_DIR := $(LIB_DIR)
C_EXE_DIR := $(EXE_DIR)

#-------------------------------------------------------------------------------
# Indpendent Mode
#-------------------------------------------------------------------------------
C_EXE_DEP_COMPONENTS := c
C_PROGRAM_COMPONENTS := c
C_INCLUDE_COMPONENTS := c

#-------------------------------------------------------------------------------
# Integrated Mode
#-------------------------------------------------------------------------------
#C_EXE_DEP_COMPONENTS := c
#C_PROGRAM_COMPONENTS := cpp c
#C_INCLUDE_COMPONENTS := c
