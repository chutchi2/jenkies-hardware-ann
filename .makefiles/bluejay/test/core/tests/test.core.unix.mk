#-------------------------------------------------------------------------------
# Filename: test.core.unix.mk
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
SOURCE_DIR := ../source

FOLDER_NOT_FOUND_DIR := $(SOURCE_DIR)/folder_not_found
EMPTY_DIR            := $(SOURCE_DIR)/empty

A_DIR   := $(SOURCE_DIR)/a
A_FILES := \
   $(A_DIR)/a.hpp \
   $(A_DIR)/a.cpp \
   $(A_DIR)/b.hpp \
   $(A_DIR)/b.cpp \
   $(A_DIR)/d.cpp \
   $(A_DIR)/.foo

B_DIR   := $(SOURCE_DIR)/b
B_FILES := \
   $(B_DIR)/b.hpp \
   $(B_DIR)/b.cpp \
   $(B_DIR)/c/c.java \
   $(B_DIR)/c/u.java \
   $(B_DIR)/c/s.c \
   $(B_DIR)/c/t.c \
   $(B_DIR)/c/d/d.hpp \
   $(B_DIR)/c/d/d.cpp \
   $(B_DIR)/c/d/u.java

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files)

# No directory : no filespec
$(call ut.assert_empty,$(call cle.find_files,,))

# No directory : *
$(call ut.assert_empty,$(call cle.find_files,,*))

# FOLDER_NOT_FOUND_DIR : *
# find: ‘../source/folder_not_found/*’: No such file or directory
$(call ut.assert_empty,$(call cle.find_files,$(FOLDER_NOT_FOUND_DIR),*))

# EMPTY_DIR : *
# find: ‘../source/empty/*’: No such file or directory
$(call ut.assert_empty,$(call cle.find_files,$(EMPTY_DIR),*))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files A_DIR)

# A_DIR : no filespec
$(call ut.assert_empty,$(call cle.find_files,$(A_DIR),))

# A_DIR : file_not_found
# find: ‘../source/a/file_not_found’: No such file or directory
actual := $(sort $(call cle.find_files,$(A_DIR),file_not_found))
$(call ut.assert_empty,$(actual))
$(call ut.assert_equal,$(words $(actual)),0)
$(call twig.undefine,actual expected)

# A_DIR : * <-- will not pick up .foo
actual := $(sort $(call cle.find_files,$(A_DIR),*))
expected := $(sort $(filter-out %/.foo,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,actual expected)

# A_DIR : *.hpp
actual := $(sort $(call cle.find_files,$(A_DIR),*.hpp))
expected := $(sort $(filter %.hpp,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,actual expected)

# A_DIR : b.cpp
actual := $(sort $(call cle.find_files,$(A_DIR),b.cpp))
expected := $(sort $(filter %b.cpp,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,actual expected)

# A_DIR : *.foo <-- will not pick up .foo
# find: ‘../source/a/*.foo’: No such file or directory
$(call ut.assert_empty,$(call cle.find_files,$(A_DIR),*.foo))

# A_DIR : .* <-- returns .foo
actual := $(sort $(call cle.find_files,$(A_DIR),.*))
expected := $(sort $(filter %/.foo,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,actual expected)

# A_DIR : *. <-- returns frog.
#actual := $(sort $(call cle.find_files,$(A_DIR),*.))
#expected := $(sort $(filter %.,$(A_FILES)))
#$(call ut.assert_equal,$(expected),$(actual))
#$(call ut.assert_equal,$(words $(actual)),1)
#$(call twig.undefine,actual expected)

# A_DIR : a/b.cpp
# find: warning: Unix filenames usually don't contain slashes (though pathnames
# do).  That means that '-name ‘a/b.cpp’' will probably evaluate to false all
# the time on this system.  You might find the '-wholename' test more useful, or
# perhaps '-samefile'.  Alternatively, if you are using GNU grep, you could use
# 'find ... -print0 | grep -FzZ ‘a/b.cpp’'.
#actual := $(sort $(call cle.find_files_ex,$(A_DIR),a/b.cpp))
#$(call ut.assert_empty,$(actual))
#$(call ut.assert_equal,$(words $(actual)),0)
#$(call twig.undefine,actual, expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files A_DIR B_DIR)

# A_DIR B_DIR : *.hpp
actual := $(sort $(call cle.find_files,$(A_DIR) $(B_DIR),*.hpp))
expected := $(sort $(filter %.hpp,$(filter-out $(B_DIR)/c/%,$(A_FILES) $(B_FILES))))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),3)
$(call twig.undefine,actual expected)

# A_DIR B_DIR : .* <-- does not emit file not found message for $(B_DIR)
actual := $(sort $(call cle.find_files,$(A_DIR) $(B_DIR),.*))
expected := $(sort $(filter %/.foo,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,actual expected)

# A_DIR B_DIR : *. <-- does emit file not found message for $(A_DIR) and $(B_DIR)
actual := $(sort $(call cle.find_files,$(A_DIR) $(B_DIR),*.))
expected := $(sort $(filter %/frog.,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),0)
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files_ex)

# No directory : no filespec
$(call ut.assert_empty,$(call cle.find_files_ex,,))

# No directory : * <-- searches current directory
actual := $(sort $(call cle.find_files_ex,,*))
# As long as there are no subdirectories with files, this will be true
expected := $(sort $(addprefix ./,$(wildcard *)))
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# FOLDER_NOT_FOUND_DIR : *
# find: ‘../source/folder_not_found’: No such file or directory
$(call ut.assert_empty,$(call cle.find_files_ex,$(FOLDER_NOT_FOUND_DIR),*))

# EMPTY_DIR : *
$(call ut.assert_empty,$(call cle.find_files_ex,$(EMPTY_DIR),*))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files_ex A_DIR)

# A_DIR : no filespec
$(call ut.assert_empty,$(call cle.find_files_ex,$(A_DIR),))

# A_DIR : file_not_found
actual := $(sort $(call cle.find_files_ex,$(A_DIR),file_not_found))
$(call ut.assert_empty,$(actual))
$(call ut.assert_equal,$(words $(actual)),0)
$(call twig.undefine,actual expected)

# A_DIR : *
actual := $(sort $(call cle.find_files_ex,$(A_DIR),*))
expected := $(sort $(A_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),6)
$(call twig.undefine,actual expected)

# A_DIR : *.hpp
actual := $(sort $(call cle.find_files_ex,$(A_DIR),*.hpp))
expected := $(sort $(filter %.hpp,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,actual expected)

# A_DIR : b.cpp
actual := $(sort $(call cle.find_files_ex,$(A_DIR),b.cpp))
expected := $(sort $(filter %b.cpp,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,actual expected)

# A_DIR : *.foo <-- returns .foo
actual := $(sort $(call cle.find_files_ex,$(A_DIR),*.foo))
expected := $(sort $(filter %.foo,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)
$(call twig.undefine,actual expected)

# A_DIR : *. <-- returns frog.
#actual := $(sort $(call cle.find_files_ex,$(A_DIR),*.))
#expected := $(sort $(filter %.,$(A_FILES)))
#$(call ut.assert_equal,$(expected),$(actual))
#$(call ut.assert_equal,$(words $(actual)),1)
#$(call twig.undefine,actual expected)

# A_DIR : a/b.cpp
# find: warning: Unix filenames usually don't contain slashes (though pathnames
# do).  That means that '-name ‘a/b.cpp’' will probably evaluate to false all
# the time on this system.  You might find the '-wholename' test more useful, or
# perhaps '-samefile'.  Alternatively, if you are using GNU grep, you could use
# 'find ... -print0 | grep -FzZ ‘a/b.cpp’'.
#actual := $(sort $(call cle.find_files_ex,$(A_DIR),a/b.cpp))
#$(call ut.assert_empty,$(actual))
#$(call ut.assert_equal,$(words $(actual)),0)
#$(call twig.undefine,actual, expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files_ex B_DIR)

# B_DIR : *
actual := $(sort $(call cle.find_files_ex,$(B_DIR),*))
expected := $(sort $(B_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),9)
$(call twig.undefine,actual expected)

# B_DIR : *.cpp
actual := $(sort $(call cle.find_files_ex,$(B_DIR),*.cpp))
expected := $(sort $(filter %.cpp,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,actual expected)

# B_DIR : u.java
actual := $(sort $(call cle.find_files_ex,$(B_DIR),u.java))
expected := $(sort $(filter %u.java,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,cle.find_files_ex A_DIR B_DIR)

# A_DIR B_DIR : *
actual := $(sort $(call cle.find_files_ex,$(A_DIR) $(B_DIR),*))
expected := $(sort $(A_FILES) $(B_FILES))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),15)
$(call twig.undefine,actual expected)

# A_DIR B_DIR : d.cpp
actual := $(sort $(call cle.find_files_ex,$(A_DIR) $(B_DIR),d.cpp))
expected := $(sort $(filter %d.cpp,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),2)
$(call twig.undefine,actual expected)

# A_DIR B_DIR : *.cpp
actual := $(sort $(call cle.find_files_ex,$(A_DIR) $(B_DIR),*.cpp))
expected := $(sort $(filter %.cpp,$(A_FILES) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,actual expected)
