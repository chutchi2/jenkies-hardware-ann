#-------------------------------------------------------------------------------
# Filename: test.utils.unsorted_pkg_list.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk
BLUEJAY_COMPONENTS := bluejay/null
include ../../../bluejay.mk

all: ; @:

#-------------------------------------------------------------------------------
# Test Variables
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,declare_unsorted_pkg_list)

#-------------------------------------------------------------------------------
# $(call function,cpp.add_source_files,$(pkg),$(source_files))
# $(call cpp.get_source_files,$(pkg))
# $(call cpp.get_all_source_files)
# $(call cpp.has_source_files,$(pkg),$(files_to_look_for))
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
# cpp.add_source_files,$(pkg),$(source_files)
# cpp.get_source_files,$(pkg)
# cpp.get_all_source_files
# cpp.has_source_files,$(pkg),$(files_to_look_for)
#-------------------------------------------------------------------------------
$(call function,declare_unsorted_pkg_list,cpp,source_files,CPP_SOURCE_FILES,CPP_PACKAGES)

barb_list := file_c.cpp file_a.cpp file_c.cpp

$(call function,cpp.add_source_files,barb,$(barb_list))
expected := $(barb_list)
$(call ut.assert_equal,$(expected),$(call cpp.get_source_files,barb))
$(call ut.assert_equal,$(expected),$(barb_CPP_SOURCE_FILES))

expected := file_a.cpp
$(call ut.assert_equal,$(expected),$(call cpp.has_source_files,barb,file_a.cpp))

rob_list := file1.hpp file1.hpp file2.hpp
$(call function,cpp.add_source_files,rob,$(rob_list))
expected := $(rob_list)
$(call ut.assert_equal,$(expected),$(call cpp.get_source_files,rob))
$(call ut.assert_equal,$(expected),$(rob_CPP_SOURCE_FILES))

expected := file1.hpp file1.hpp
$(call ut.assert_equal,$(expected),$(call cpp.has_source_files,rob,file1.hpp))

CPP_PACKAGES := rob barb
expected := $(rob_list) $(barb_list)
$(call ut.assert_equal,$(expected),$(call cpp.get_all_source_files))
