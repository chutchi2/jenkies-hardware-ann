#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------
makefiles := \
   toolchains/bluejay/gnu.c.mk \
   toolchains/bluejay/gnu.c.defaults.mk \
   toolchains/bluejay/gnu.cpp.mk \
   toolchains/bluejay/gnu.cpp.defaults.mk \
   toolchains/bluejay/gnu.ar.defaults.mk \
   toolchains/bluejay/gnu.ar.mk

$(call bootstrap.include_makefiles,$(makefiles))
#-------------------------------------------------------------------------------
