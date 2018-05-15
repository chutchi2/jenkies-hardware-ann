#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define cpp.linker.stage_5
   $(call function,cpp.linker.assemble_flags)
endef

#-------------------------------------------------------------------------------
define cpp.linker.assemble_flags
   $(warning cpp.linker.assemble_flags not defined by the toolchain)
endef
