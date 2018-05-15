#-------------------------------------------------------------------------------
# Filename cpp.flags.mk
#
# Description:
# Define additional command line switches (flags) for the C++ compiler.
#-------------------------------------------------------------------------------
CPP_DEFINES := \
   ENABLE_IO \
   ENABLE_ASSERT \
   ENABLE_DIAGNOSTICS

CPP_FLAGS := \
   -g \
   -ansi \
   -std=c++14 \
   -Wall \
   -Wextra \
   -Wpedantic \
   -Werror
