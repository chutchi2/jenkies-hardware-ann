#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define std.archiver.stage_5
   $(call function,std.archiver.assemble_flags)
endef

#-------------------------------------------------------------------------------
define std.archiver.assemble_flags
   $(warning std.archiver.assemble_flags not defined by the toolchain)
endef
