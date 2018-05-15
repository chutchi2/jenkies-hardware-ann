#-------------------------------------------------------------------------------
# Filename: platform.mk
#
# Description:
# Contains platform specific build content.
#-------------------------------------------------------------------------------
#C_EXE_EXT   := exe
#CPP_EXE_EXT := exe

#-------------------------------------------------------------------------------
$(call function,external_package.import_externals,\
   $(PROJECT_EXTERNALS_DIR)/linux-x86_64-gcc_6.3.1 \
   $(TEST_EXTERNALS_DIR)/linux-x86_64-gcc_4.4.7)
