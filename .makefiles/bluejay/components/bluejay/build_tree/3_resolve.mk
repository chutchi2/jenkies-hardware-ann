#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define build_tree.stage_3
   $(call function,build_tree.resolve_clean_dirs)
endef

#-------------------------------------------------------------------------------
define build_tree.resolve_clean_dirs

   ifeq ($(abspath $(BLUEJAY_BUILD_DIR)),$(abspath $(CURDIR)))
      $$(eval CLEAN_DIRS := $$(sort $$(CLEAN_DIRS) $$(BUILD_DIRS)))
   else
      $$(eval CLEAN_DIRS := \
         $$(sort \
            $$(CLEAN_DIRS) \
            $$(BLUEJAY_BUILD_DIR) \
            $$(filter-out $$(BLUEJAY_BUILD_DIR)/%,$$(BUILD_DIRS))))
   endif

   $$(foreach &dir,$$(CLEAN_DIRS),\
      $$(eval CLEAN_DIRS := $$(filter-out $$(&dir)/%,$$(CLEAN_DIRS))))

endef
