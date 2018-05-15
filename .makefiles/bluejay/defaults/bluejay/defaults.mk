#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
makefiles := \
   defaults/bluejay/core.defaults.mk \
   defaults/bluejay/std.defaults.mk \
   defaults/bluejay/c.defaults.mk \
   defaults/bluejay/cpp.defaults.mk \
   defaults/bluejay/ar.defaults.mk

$(call bootstrap.include_makefiles,$(makefiles))
#-------------------------------------------------------------------------------
