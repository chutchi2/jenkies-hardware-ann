#-------------------------------------------------------------------------------
# File:
#
# Description:
#
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
define c.linker.stage_5
   $(call function,c.linker.assemble_flags)
endef

#-------------------------------------------------------------------------------
define c.linker.assemble_flags
   $(warning c.linker.assemble_flags not defined by the toolchain)
endef
