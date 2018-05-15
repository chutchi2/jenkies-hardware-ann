#-------------------------------------------------------------------------------
# File: gnu.c.defaults.mk
#
# Description:
# Defines default values for variables used by the gnu.c toolchain.
#
# * Variables defined in this file can be overriden by defining them AFTER
#   including bluejay.mk.
#
#-------------------------------------------------------------------------------

# TODO: Clean this up

C_DEFINES      :=
C_FLAGS        :=

C_GLOBAL_INCLUDES_FLAG := -I
C_QUOTED_INCLUDES_FLAG := -iquote
C_SYSTEM_INCLUDES_FLAG := -isystem

C_LD_FLAGS     :=

C_LD_USER_LIBS :=

C_LD_LIB_DIRS  :=
C_LD_LIBS      :=
 
C_COMPILER     := gcc
C_LINKER       := gcc

