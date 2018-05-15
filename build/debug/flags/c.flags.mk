#-------------------------------------------------------------------------------
# Filename: c.flags.mk
#
# Description:
# Define additional command line switches (flags) for the C compiler.
#-------------------------------------------------------------------------------
C_DEFINES := \
   DEBUG

C_FLAGS := \
   -g \
   -ansi \
   -Wall \
   -Wextra \
   -Werror
