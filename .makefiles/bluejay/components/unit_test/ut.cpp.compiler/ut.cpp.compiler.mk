#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define ut.cpp.compiler.stage_3
   $(foreach &pkg,$(CPP_PACKAGES),\
      $(foreach &dir,\
         $(filter-out $($(&pkg)_CPP_PUBLIC_INCLUDES),\
            $(filter $(SOURCE_PACKAGES)%,$($(&pkg)_CPP_SOURCE_DIRS))),\
         $(call function,cpp.add_private_includes,$(UT_NAME),$(call cpp.find_includes,$(&dir)))))

   $(call function,cpp.resolve_private_includes,$(UT_NAME))
endef
