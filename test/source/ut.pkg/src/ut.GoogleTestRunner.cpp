/*------------------------------------------------------------------------------
Filename: ut.GoogleTestRunner.cpp

Description:
Initializes and executes unit tests that use the google test framework.
------------------------------------------------------------------------------*/
#include "ut.GoogleTestRunner.hpp"
#include <gtest/gtest.h>

using namespace ut;

//------------------------------------------------------------------------------
// virtual
int GoogleTestRunner::execute( int argc, char **argv )
{
    ::testing::InitGoogleTest( &argc, argv );
    return RUN_ALL_TESTS();
}
