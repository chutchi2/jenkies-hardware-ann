#!/bin/bash
#-------------------------------------------------------------------------------
# Filename: unit_test.sh
#
# Description:
# Bash functions used for building and executing unit tests.
#
# Usage:
# source unit_test.sh
#-------------------------------------------------------------------------------
UNIT_TEST_BUILD_DIR=build

#-------------------------------------------------------------------------------
# Print a line of dashes.
#
# Arguments:
# $1 - length [optional] [default=64]
#-------------------------------------------------------------------------------
function print_line()
{
   local len="${1:-64}"

   printf -- '-%0.0s' $(seq 1 $len)
   printf "\n"
}

#-------------------------------------------------------------------------------
# Print separator.
#
# Arguments:
# $1 - length [optional] [default=64]
#-------------------------------------------------------------------------------
function print_separator()
{
   local len="${1:-64}"

   printf "\n"
   print_line "$len"
}

#-------------------------------------------------------------------------------
# Print level 1 header.
#
# Arguments:
# $1 - header message
#-------------------------------------------------------------------------------
function print_header_1()
{
   echo "==> $1"
}

#-------------------------------------------------------------------------------
# Find unit tests.
#
# Directory names that begin with an underscore are ignored.
#
# Directories that are explicitly specified with an underscore will not be
# ignored.
#
# If the variable 'INCLUDE_ALL' is defined, no checks for underscores will take
# place.
#
# The results are placed into the variable 'UNIT_TESTS' as an array.
#
# Arguments:
# $@ - list of base directories to search
#
# Global Variables:
# [input]  INCLUDE_ALL - if defined, do not check for disabled unit tests
# [input]  UNIT_TEST_BUILD_DIR - the build directory within a unit test
# [output] UNIT_TESTS  - the results are placed here as an array
#-------------------------------------------------------------------------------
function find_unit_tests()
{
   local makefile_path=$UNIT_TEST_BUILD_DIR/makefile
   local unit_tests=()
   
   # For each directory passed into the function
   for dir in "$@"; do
      
      # Remove trailing '/'
      dir=${dir%/}

      # Make sure $dir is really a directory
      if [ ! -d "$dir" ]; then
         echo "Can't find '$dir'. Skipping..."
         continue
      fi

      # If the directory is a unit test, add it directly
      if [ -e "$dir/$makefile_path" ]; then

         unit_tests+=("$dir")

      # Otherwise search for unit tests and filter out paths that contain a
      # directory that begin with an underscore
      else

         # This incantation allows for spaces in the path
         while IFS=  read -r -d $'\0'; do

            # Remove the $dir portion and look for '/_'
            if [[ -n ${INCLUDE_ALL+x} || ! "${REPLY#$dir}" =~ "/_" ]]; then
               # Add the path to the unit test by removing the $makefile_path
               unit_tests+=("${REPLY%/$makefile_path}")
            fi

         done < <(find "$dir" -path "*/$makefile_path" -print0)

      fi

   done

   #print_header_1 "unit_tests"
   #for u in "${unit_tests[@]}"; do
   #   echo "$u"
   #done

   # A global variable is the simplest way to return an array
   UNIT_TESTS=("${unit_tests[@]}")
}

#-------------------------------------------------------------------------------
# Finds unit tests and report the number found.
#
# If 'TEST_DIRS' is empty, the current directory will be searched.
#
# Arguments:
# None
#
# Global Variables:
# [input]  INCLUDE_ALL - if defined, do not check for disabled unit tests
# [input]  TEST_DIRS   - directories to search for unit tests
# [output] UNIT_TESTS  - the results are placed here as an array
#-------------------------------------------------------------------------------
function get_unit_tests()
{
   # Find unit tests
   if [ ${#TEST_DIRS[@]} -eq 0 ]; then
      find_unit_tests "."
   else
      find_unit_tests "${TEST_DIRS[@]}"
   fi

   # Report number of unit tests that were found
   if [ ${#UNIT_TESTS[@]} -eq 0 ]; then
      echo "No unit tests found."
      return 1
   else
      echo "${#UNIT_TESTS[@]} unit tests found."
   fi
}

#-------------------------------------------------------------------------------
# Parse command line arguments.
#
# Arguments:
# $@ - command line arguments
#
# Global Variables:
# [output] ARGS        - arguments are placed here as an array
# [output] INCLUDE_ALL - will be defined if the '--all' option is present
# [output] TEST_DIRS   - directories are placed here as an array
#-------------------------------------------------------------------------------
function parse_cmd_line()
{
   TEST_DIRS=()
   ARGS=()

   # Parse command line arguments
   for opt in "$@"; do

      case $opt in

         --help)
            print_usage
            exit
            ;;

         --all)
            INCLUDE_ALL=yes
            shift
            ;;

         --)
            shift
            TEST_DIRS+=("$@")
            break
            ;;

         -*|*=*)
            ARGS+=("$opt")
            shift
            ;;

         *)
            if [ -d "$opt" ]; then
               TEST_DIRS+=("$opt")
            else
               ARGS+=("$opt")
            fi
            shift
            ;;

      esac

   done

   #print_header_1 "TEST_DIRS"
   #for d in "${TEST_DIRS[@]}"; do
   #   echo "$d"
   #done

   #print_header_1 "ARGS"
   #for a in "${ARGS[@]}"; do
   #   echo "$a"
   #done
}
