#-------------------------------------------------------------------------------
# Filename: test.cpp.source_files.mk
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
   $(A_DIR)/a.cpp \
   $(A_DIR)/b.cpp

B_DIR   := $(SOURCE_DIR)/b
B_FILES := \
   $(B_DIR)/b.cpp \
   $(B_DIR)/c/c.cpp \
   $(B_DIR)/c/d/d.cc \
   $(B_DIR)/c/d/e/e.cpp

PACKAGE := dummy

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.add_source_files)

# No package : A_FILES
# test.cpp.source_files.mk:39: Package name is empty.
$(call function,cpp.add_source_files,,$(A_FILES))

actual = $($(PACKAGE)_CPP_SOURCE_FILES)

# PACKAGE : empty_filelist
empty_filelist :=
$(call function,cpp.add_source_files,$(PACKAGE),$(empty_filelist))
$(call ut.assert_empty,$(actual))

# PACKAGE : filelist_1
filelist_1 := d.foo c.bar
$(call ut.assert_empty,$(actual))
$(call function,cpp.add_source_files,\
   $(PACKAGE),\
   $(filelist_1))
$(call ut.assert_equal,$(sort $(filelist_1)),$(actual))

# PACKAGE : filelist_2
filelist_2 := a.foo b.bar
$(call function,cpp.add_source_files,$(PACKAGE),$(filelist_2))
$(call ut.assert_equal,$(sort $(filelist_1) $(filelist_2)),$(actual))

$(call twig.undefine,filelist_1 filelist_2 empty_filelist)
$(call twig.undefine,actual $(PACKAGE)_CPP_SOURCE_FILES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.find_source_files)

# No directory : no exclusion list
$(call ut.assert_empty,$(call cpp.find_source_files,,))

# No directory : .cpp
$(call ut.assert_empty,$(call cpp.find_source_files,,.cpp))

# EMPTY_DIR : no exclusion list
$(call ut.assert_empty,$(call cpp.find_source_files,$(EMPTY_DIR)))

# A_DIR : no exclusion list
actual := $(call cpp.find_source_files,$(A_DIR))
expected := $(sort $(A_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,expected actual)

# A_DIR B_DIR: a.cpp
actual := $(call cpp.find_source_files,$(A_DIR) $(B_DIR),a.cpp)
expected := $(sort $(filter-out $(B_DIR)/c/% %a.cpp,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,expected actual)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.discover_source_files)

actual = $($(PACKAGE)_CPP_SOURCE_FILES)

# No package : no directory : no exclusion list
# test.cpp.source_files.mk:96: Package name is empty.
$(call function,cpp.discover_source_files,,,)
$(call ut.assert_empty,$(actual))

# PACKAGE : no directory : no exclusion list
$(call function,cpp.discover_source_files,$(PACKAGE),,)
$(call ut.assert_empty,$(actual))

# PACKAGE : EMPTY_DIR : no exclusion list
$(call function,cpp.discover_source_files,$(PACKAGE),$(EMPTY_DIR),)
$(call ut.assert_empty,$(actual))

# PACKAGE : A_DIR B_DIR : a/b.cpp
$(call function,cpp.discover_source_files,$(PACKAGE),$(A_DIR) $(B_DIR),a/b.cpp)
expected := $(sort $(filter-out $(B_DIR)/c/% %a/b.cpp,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,expected)

$(call twig.undefine,actual $(PACKAGE)_CPP_SOURCE_FILES)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.find_source_files_ex)

# No directory : no exclusion list
$(call ut.assert_empty,$(call cpp.find_source_files_ex,,))

# No directory : .cpp
$(call ut.assert_empty,$(call cpp.find_source_files_ex,,.cpp))

# EMPTY_DIR : no exclusion list
$(call ut.assert_empty,$(call cpp.find_source_files_ex,$(EMPTY_DIR)))

# B_DIR : no exclusion list
actual := $(sort $(call cpp.find_source_files_ex,$(B_DIR)))
expected := $(sort $(B_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),4)
$(call twig.undefine,expected actual)

# A_DIR B_DIR: c/c.cpp
actual := $(sort $(call cpp.find_source_files_ex,$(A_DIR) $(B_DIR),c/c.cpp))
expected := $(sort $(filter-out %c/c.cpp,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,expected actual)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cpp.discover_source_files_ex)

actual = $($(PACKAGE)_CPP_SOURCE_FILES)

# No package : no directory : no exclusion list
# test.cpp.source_files.mk:150: Package name is empty.
$(call function,cpp.discover_source_files_ex,,,)
$(call ut.assert_empty,$(actual))

# PACKAGE : No directory : no exclusion list
$(call function,cpp.discover_source_files_ex,$(PACKAGE),,)
$(call ut.assert_empty,$(actual))

# PACKAGE : EMPTY_DIR : no exclusion list
$(call function,cpp.discover_source_files_ex,$(PACKAGE),$(EMPTY_DIR),)
$(call ut.assert_empty,$(actual))

# PACKAGE : A_DIR B_DIR : B_DIR/c/d/*.c*
ex := $(call find_files_ex,$(B_DIR)/c/d,cc cpp)
$(call function,cpp.discover_source_files_ex,$(PACKAGE),$(A_DIR) $(B_DIR),$(ex))
expected := $(sort $(filter-out $(ex),$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),4)
$(call twig.undefine,expected list)

$(call twig.undefine,actual $(PACKAGE)_CPP_SOURCE_FILES)
