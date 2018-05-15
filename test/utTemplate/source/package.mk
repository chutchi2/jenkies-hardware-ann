#-------------------------------------------------------------------------------
# Filename: package.mk
#
# Description:
# Bluejay package definition file.
#-------------------------------------------------------------------------------
PACKAGE := $(UT_NAME)
$(call function,cpp.import_main)
$(call function,cpp.import_dir)
