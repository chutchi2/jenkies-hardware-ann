#-------------------------------------------------------------------------------
# Filename: test.cpp.include_paths.mk
#
# Description:
# This file ...
#-------------------------------------------------------------------------------
include ../../unit_test.mk
BLUEJAY_COMPONENTS := bluejay/standard/cpp/cpp.compiler
include ../../../bluejay.mk

all: ; @:

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------
SOURCE_DIR := ../source

EMPTY_DIR  := $(SOURCE_DIR)/empty

A_DIR   := $(SOURCE_DIR)/a
A_FILES := \
   $(A_DIR)/a.hpp \
   $(A_DIR)/b.hpp

B_DIR   := $(SOURCE_DIR)/b
B_FILES := \
   $(B_DIR)/b.hpp \
   $(B_DIR)/c/c.hpp \
   $(B_DIR)/c/d/d.hh \
   $(B_DIR)/c/d/e/e.hpp

PACKAGE := dummy

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.find_header_files)

# No directory
$(call ut.assert_empty,$(call cpp.find_header_files,))

# EMPTY_DIR
$(call ut.assert_empty,$(call cpp.find_header_files,$(EMPTY_DIR)))

# A_DIR
actual := $(sort $(call cpp.find_header_files,$(A_DIR)))
expected := $(sort $(A_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,expected actual)

# A_DIR B_DIR
actual := $(sort $(call cpp.find_header_files,$(A_DIR) $(B_DIR)))
expected := $(sort $(filter-out $(B_DIR)/c/%,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),3)
$(call twig.undefine,expected actual)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.find_header_files_ex)

# No directory
$(call ut.assert_empty,$(call cpp.find_header_files_ex,))

# EMPTY_DIR
$(call ut.assert_empty,$(call cpp.find_header_files_ex,$(EMPTY_DIR)))

# B_DIR
actual := $(sort $(call cpp.find_header_files_ex,$(B_DIR)))
expected := $(sort $(B_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),4)
$(call twig.undefine,expected actual)

# A_DIR B_DIR
actual := $(sort $(call cpp.find_header_files_ex,$(A_DIR) $(B_DIR)))
expected := $(sort $(A_FILES) $(B_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),6)
$(call twig.undefine,expected actual)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.find_includes)

# No directory
$(call ut.assert_empty,$(call cpp.find_includes,))

# EMPTY_DIR
$(call ut.assert_empty,$(call cpp.find_includes,$(EMPTY_DIR)))

# A_DIR
actual := $(sort $(call cpp.find_includes,$(A_DIR)))
expected := $(sort $(call path,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,expected actual)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.find_includes_ex)

# No directory
$(call ut.assert_empty,$(call cpp.find_includes_ex,))

# EMPTY_DIR
$(call ut.assert_empty,$(call cpp.find_includes_ex,$(EMPTY_DIR)))

# B_DIR
actual := $(sort $(call cpp.find_includes_ex,$(B_DIR)))
expected := $(sort $(call path,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),4)
$(call twig.undefine,expected actual)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.add_public_includes)

# No package : no directory
# test.cpp.include_paths.mk:xxx: Package name is empty.
$(call function,cpp.add_public_includes,,)

actual = $($(PACKAGE)_CPP_PUBLIC_INCLUDES)

# PACKAGE : empty_filelist
empty_filelist :=
$(call function,cpp.add_public_includes,$(PACKAGE),$(empty_filelist))
$(call ut.assert_empty,$(actual))

# PACKAGE : filelist_1
filelist_1 := $(A_DIR) $(B_DIR)
$(call ut.assert_empty,$(actual))
$(call function,cpp.add_public_includes,$(PACKAGE),$(filelist_1))
$(call ut.assert_equal,$(sort $(filelist_1)),$(actual))

# PACKAGE : filelist_2
filelist_2 := $(EMPTY_DIR) $(B_DIR)
$(call function,cpp.add_public_includes,$(PACKAGE),$(filelist_2))
$(call ut.assert_equal,$(sort $(filelist_1) $(EMPTY_DIR)),$(actual))

$(call twig.undefine,filelist_1 filelist_2 empty_filelist)
$(call twig.undefine,actual $(PACKAGE)_CPP_PUBLIC_INCLUDES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.add_private_includes)

# No package : no directory
# test.cpp.include_paths.mk:xxx: Package name is empty.
$(call function,cpp.add_private_includes,,)

actual = $($(PACKAGE)_CPP_PRIVATE_INCLUDES)

# PACKAGE : empty_filelist
empty_filelist :=
$(call function,cpp.add_private_includes,$(PACKAGE),$(empty_filelist))
$(call ut.assert_empty,$(actual))

# PACKAGE : filelist_1
filelist_1 := $(A_DIR) $(B_DIR)
$(call ut.assert_empty,$(actual))
$(call function,cpp.add_private_includes,$(PACKAGE),$(filelist_1))
$(call ut.assert_equal,$(sort $(filelist_1)),$(actual))

# PACKAGE : filelist_2
filelist_2 := $(EMPTY_DIR) $(B_DIR)
$(call function,cpp.add_private_includes,$(PACKAGE),$(filelist_2))
$(call ut.assert_equal,$(sort $(filelist_1) $(EMPTY_DIR)),$(actual))

$(call twig.undefine,filelist_1 filelist_2 empty_filelist)
$(call twig.undefine,actual $(PACKAGE)_CPP_PRIVATE_INCLUDES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.discover_public_includes)

actual = $($(PACKAGE)_CPP_PUBLIC_INCLUDES)

# No package : no directory
# test.cpp.include_paths.mk:xxx: Package name is empty.
$(call function,cpp.discover_public_includes,,)
$(call ut.assert_empty,$(actual))

# PACKAGE : no directory
$(call function,cpp.discover_public_includes,$(PACKAGE),)
$(call ut.assert_empty,$(actual))

# PACKAGE : EMPTY_DIR
$(call function,cpp.discover_public_includes,$(PACKAGE),$(EMPTY_DIR))
$(call ut.assert_empty,$(actual))

# PACKAGE : A_DIR
$(call function,cpp.discover_public_includes,$(PACKAGE),$(A_DIR))
expected := $(A_DIR)
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,expected)

# PACKAGE : B_DIR
$(call function,cpp.discover_public_includes,$(PACKAGE),$(A_DIR) $(B_DIR))
expected := $(sort $(A_DIR) $(B_DIR))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,expected)

$(call twig.undefine,actual $(PACKAGE)_CPP_PUBLIC_INCLUDES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.discover_public_includes_ex)

actual = $($(PACKAGE)_CPP_PUBLIC_INCLUDES)

# No package : no directory
# test.cpp.include_paths.mk:xxx: Package name is empty.
$(call function,cpp.discover_public_includes_ex,,)
$(call ut.assert_empty,$(actual))

# PACKAGE : no directory
$(call function,cpp.discover_public_includes_ex,$(PACKAGE),)
$(call ut.assert_empty,$(actual))

# PACKAGE : EMPTY_DIR
$(call function,cpp.discover_public_includes_ex,$(PACKAGE),$(EMPTY_DIR))
$(call ut.assert_empty,$(actual))

# PACKAGE : A_DIR B_DIR
$(call function,cpp.discover_public_includes_ex,$(PACKAGE),$(A_DIR) $(B_DIR))
expected := $(sort $(A_DIR) $(call path,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,expected)

$(call twig.undefine,actual $(PACKAGE)_CPP_PUBLIC_INCLUDES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.discover_private_includes_ex)

actual = $($(PACKAGE)_CPP_PRIVATE_INCLUDES)

# No package : no directory
# test.cpp.include_paths.mk:xxx: Package name is empty.
$(call function,cpp.discover_private_includes_ex,,)
$(call ut.assert_empty,$(actual))

# PACKAGE : no directory
$(call function,cpp.discover_private_includes_ex,$(PACKAGE),)
$(call ut.assert_empty,$(actual))

# PACKAGE : EMPTY_DIR
$(call function,cpp.discover_private_includes_ex,$(PACKAGE),$(EMPTY_DIR))
$(call ut.assert_empty,$(actual))

# PACKAGE : B_DIR
$(call function,cpp.discover_private_includes_ex,$(PACKAGE),$(B_DIR))
expected := $(sort $(call path,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),4)
$(call twig.undefine,expected)

# PACKAGE : A_DIR B_DIR
$(call function,cpp.discover_private_includes_ex,$(PACKAGE),$(A_DIR) $(B_DIR))
expected := $(sort $(A_DIR) $(call path,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,expected)

$(call twig.undefine,actual $(PACKAGE)_CPP_PRIVATE_INCLUDES)
