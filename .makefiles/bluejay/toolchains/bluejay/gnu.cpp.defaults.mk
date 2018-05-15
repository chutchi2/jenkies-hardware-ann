#-------------------------------------------------------------------------------
# File: gnu.cpp.defaults.mk
#
# Description:
# Defines default values for variables used by the gnu.cpp toolchain.
#
# * Variables defined in this file can be overriden by defining them AFTER
#   including bluejay.mk.
#
#-------------------------------------------------------------------------------

# TODO: Clean this up

CPP_DEFINES      :=
CPP_FLAGS        :=

CPP_GLOBAL_INCLUDES_FLAG := -I
CPP_QUOTED_INCLUDES_FLAG := -iquote
CPP_SYSTEM_INCLUDES_FLAG := -isystem

CPP_LD_FLAGS     :=

CPP_LD_USER_LIBS :=

CPP_LD_LIB_DIRS  :=
CPP_LD_LIBS      :=
 
CPP_COMPILER     := g++
CPP_LINKER       := g++
