#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.archiver.stage_5
   $(call function,c.archiver.assemble_flags)
endef

#-------------------------------------------------------------------------------
define c.archiver.assemble_flags
   $(warning c.archiver.assemble_flags not defined by the toolchain)
endef
