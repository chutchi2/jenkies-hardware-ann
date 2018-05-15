#-------------------------------------------------------------------------------
# Filename: makefile
#
# Description:
# Top-level makefile
#-------------------------------------------------------------------------------
BLUEJAY_BUILD_DIR := .build

#-------------------------------------------------------------------------------
PROJECT_DIR := ../..
include $(PROJECT_DIR)/.makefiles/project_structure.mk
include $(BLUEJAY_DIR)/bluejay.mk
include packages.mk

#-------------------------------------------------------------------------------
PACKAGE_DIRS      := $(SOURCE_PACKAGES)

C_FLAGS_FILE      := flags/c.flags.mk
C_LD_FLAGS_FILE   := flags/c.ld.flags.mk

CPP_FLAGS_FILE    := flags/cpp.flags.mk
CPP_LD_FLAGS_FILE := flags/cpp.ld.flags.mk

AR_FLAGS_FILE     := flags/ar.flags.mk

#C_EXE_EXT   := exe
#CPP_EXE_EXT := exe

#-------------------------------------------------------------------------------
include $(PROJECT_MAKE_DIR)/external_package.mk
$(call function,external_package.import_externals,\
   $(PROJECT_EXTERNALS_DIR)/linux-x86_64-gcc_6.3.1)

#-------------------------------------------------------------------------------
$(call function,bluejay.assemble)
all: $(EXECUTABLES)
