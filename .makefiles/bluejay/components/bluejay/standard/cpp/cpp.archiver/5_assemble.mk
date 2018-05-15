#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.archiver.stage_5
   $(call function,cpp.archiver.assemble_flags)
endef

#-------------------------------------------------------------------------------
define cpp.archiver.assemble_flags
   $(warning cpp.archiver.assemble_flags not defined by the toolchain)
endef
