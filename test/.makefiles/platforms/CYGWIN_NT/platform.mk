#-------------------------------------------------------------------------------
# Filename: platform.mk
#
# Description:
# Contains platform specific build content.
#-------------------------------------------------------------------------------
C_EXE_EXT   := exe
CPP_EXE_EXT := exe

#-------------------------------------------------------------------------------
$(call function,external_package.import_externals,\
   $(TEST_EXTERNALS_DIR)/cygwin-x86_64-gcc_5.4.0)
