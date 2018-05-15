#-------------------------------------------------------------------------------
# File: package.mk
#
# Description:
#
#-------------------------------------------------------------------------------
#PACKAGE := $(DIR_NAME)

$(call ut.assert_equal,.,$(PACKAGE_DIR))
$(call ut.assert_equal,tests,$(DIR_NAME))
$(call ut.assert_equal,tests,$(PACKAGE))
