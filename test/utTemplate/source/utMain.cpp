/*------------------------------------------------------------------------------
Filename: utMain.cpp

Description:
Unit test code using the google test framework.
------------------------------------------------------------------------------*/
#include "ut.GoogleTestRunner.hpp"
#include <gtest/gtest.h>

//------------------------------------------------------------------------------
TEST( utTemplate, test )
{
}

//------------------------------------------------------------------------------
int main( int argc, char **argv )
{
    ut::GoogleTestRunner runner;
    runner.registerConsoleHandler();
    return runner.execute( argc, argv );
}
