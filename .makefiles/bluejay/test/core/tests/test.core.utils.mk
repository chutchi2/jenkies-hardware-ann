#-------------------------------------------------------------------------------
# Filename: test.core.utils.mk
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
   $(A_DIR)/files.cpp \
   $(A_DIR)/.foo
A_FILES_EX := $(filter-out %/files.cpp,$(A_FILES))

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
# Define fruits and veggies
FRUITS := apple grape banana
apple  := a
banana := b
grape  := g
apple_color  := red
banana_color := yellow

VEGGIES := carrot pea
carrot_color := orange
pea_color    := green

#-------------------------------------------------------------------------------
# Tests
#-------------------------------------------------------------------------------

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,expand)

# No list
$(call ut.assert_empty,$(call expand,))

# Expand an empty list
list :=
$(call ut.assert_empty,$(call expand,list))
$(call twig.undefine,list)

# Expand 2 empty lists
list1 :=
list2 :=
$(call ut.assert_empty,$(call expand,list1 list2))
$(call twig.undefine,list1 list2)

# Expand list
list := apples oranges
actual := $(call expand,list)
expected := $(list)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,list)
$(call twig.undefine,actual expected)

# Expand list of lists
actual := $(call expand,$(FRUITS:=_color))
expected := $(apple_color) $(banana_color)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,compound_expand)

# No list : no suffix
$(call ut.assert_empty,$(call compound_expand,,))

# No list : _color
$(call ut.assert_empty,$(call compound_expand,,_color))

# VEGGIES : no suffix
$(call ut.assert_empty,$(call compound_expand,VEGGIES))

# FRUITS : _price
$(call ut.assert_empty,$(call compound_expand,FRUITS,_price))

# VEGGIES FRUITS : _price
$(call ut.assert_empty,$(call compound_expand,VEGGIES FRUITS,_price))

# FRUITS : no suffix
actual := $(call compound_expand,FRUITS,)
expected := $(call expand,$(call expand,FRUITS))
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# FRUITS : _color
actual := $(call compound_expand,FRUITS,_color)
expected := $(apple_color) $(banana_color)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# FRUITS VEGGIES : _color
actual := $(call compound_expand,FRUITS VEGGIES,_color)
expected := $(apple_color) $(banana_color) $(carrot_color) $(pea_color)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,path)

# No path
$(call ut.assert_empty,$(call path,))

# Filename only
actual := $(call path,filename)
expected := .
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# . .. ./ ../ ./a ../b/../
actual := $(call path,. .. ./ ../ ./a ../b/../)
expected := . . . .. . ../b/..
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

# A_DIR B_DIR
actual := $(call path,$(A_DIR) $(B_DIR))
expected := $(SOURCE_DIR) $(SOURCE_DIR)
$(call ut.assert_equal,$(expected),$(actual))
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files)

# No directory : no extension
$(call ut.assert_empty,$(call find_files,,))

# No directory : ico
$(call ut.assert_empty,$(call find_files,,ico))

# No directory : hpp cpp
$(call ut.assert_empty,$(call find_files,,hpp cpp))

# EMPTY_DIR : cpp
$(call ut.assert_empty,$(call find_files,$(EMPTY_DIR),cpp))

# EMPTY_DIR : hpp cpp
$(call ut.assert_empty,$(call find_files,$(EMPTY_DIR),hpp cpp))

# EMPTY_DIR EMPTY_DIR : hpp
$(call ut.assert_empty,$(call find_files,$(EMPTY_DIR) $(EMPTY_DIR),hpp cpp))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files A_DIR)

# A_DIR : no extension
$(call ut.assert_empty,$(call find_files,$(A_DIR),))

# A_DIR : java
$(call ut.assert_empty,$(call find_files,$(A_DIR),java))

# A_DIR : foo <-- will not pick up .foo
$(call ut.assert_empty,$(call find_files,$(A_DIR),foo))

# A_DIR : cpp
actual := $(sort $(call find_files,$(A_DIR),cpp))
expected := $(sort $(filter %.cpp,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),4)
$(call twig.undefine,actual expected)

# A_DIR : cpp hpp
actual := $(sort $(call find_files,$(A_DIR),cpp hpp))
expected := $(sort $(filter %.cpp %.hpp,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),6)
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files A_DIR B_DIR)

# A_DIR B_DIR : hpp cpp
actual := $(sort \
            $(call find_files,\
               $(A_DIR) $(B_DIR),\
               hpp cpp))

expected := \
   $(sort \
      $(filter %.hpp %.cpp,\
         $(filter-out $(B_DIR)/c/%,$(A_FILES) $(B_FILES))))

$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),8)
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files_ex)

# No directory : no extension
$(call ut.assert_empty,$(call find_files_ex,,))

# No directory : cpp
$(call ut.assert_empty,$(call find_files_ex,,cpp))

# No directory : hpp cpp
$(call ut.assert_empty,$(call find_files_ex,,hpp cpp))

# EMPTY_DIR : cpp
$(call ut.assert_empty,$(call find_files_ex,$(EMPTY_DIR),cpp))

# EMPTY_DIR : hpp cpp
$(call ut.assert_empty,$(call find_files_ex,$(EMPTY_DIR),hpp cpp))

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files_ex A_DIR)

# A_DIR : no extension
$(call ut.assert_empty,$(call find_files_ex,$(A_DIR),))

# A_DIR : java
$(call ut.assert_empty,$(call find_files_ex,$(A_DIR),java))

# A_DIR : foo <-- will pick up .foo
actual := $(sort $(call find_files_ex,$(A_DIR),foo))
expected := $(sort $(filter %.foo,$(A_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),1)

# A_DIR : cpp
actual := $(sort $(call find_files_ex,$(A_DIR),cpp))
expected := $(sort $(filter %.cpp,$(A_FILES_EX)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),3)
$(call twig.undefine,actual expected)

# A_DIR : cpp hpp
actual := $(sort $(call find_files_ex,$(A_DIR),cpp hpp))
expected := $(sort $(filter %.cpp %.hpp,$(A_FILES_EX)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files_ex B_DIR)

# B_DIR : java
actual := $(sort $(call find_files_ex,$(B_DIR),java))
expected := $(sort $(filter %.java,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),3)
$(call twig.undefine,actual expected)

# B_DIR : hpp java
actual := $(sort $(call find_files_ex,$(B_DIR),hpp java))
expected := $(sort $(filter %.hpp %.java,$(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),5)
$(call twig.undefine,actual expected)

#-------------------------------------------------------------------------------
$(call BEGIN_TEST,find_files_ex A_DIR B_DIR)

# A_DIR B_DIR : c cpp
actual := $(sort \
            $(call find_files_ex,\
               $(A_DIR) $(B_DIR),\
               c cpp))

expected := $(sort $(filter %.c %.cpp,$(A_FILES_EX) $(B_FILES)))
$(call ut.assert_equal,$(expected),$(actual))
$(call ut.assert_equal,$(words $(actual)),7)
$(call twig.undefine,actual expected)
