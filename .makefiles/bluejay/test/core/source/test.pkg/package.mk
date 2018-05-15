#-------------------------------------------------------------------------------
# File: package.mk
#
# Description:
#
#-------------------------------------------------------------------------------
$(call ut.assert_equal,test,$(PACKAGE))

PACKAGE := overflow

$(call ut.assert_equal,../source/test.pkg,$(PACKAGE_DIR))
$(call ut.assert_equal,test.pkg,$(DIR_NAME))
$(call ut.assert_equal,overflow,$(PACKAGE))

# Not what I would expect!
$(call ut.assert_equal,try_function,$(0))
$(call ut.assert_equal,package.add_package,$(1))
$(call ut.assert_equal,$(PACKAGE_DIR)/$(PACKAGE_MK),$(2))
