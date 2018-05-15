// Classification: UNCLASSIFIED

/*------------------------------------------------------------------------------
Filename: ut.GoogleTestRunner.hpp

Description:
Initializes and executes unit tests that use the google test framework.

Copyright (c) 2017 Cosmic AES. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef ut_GoogleTestRunner_hpp
#define ut_GoogleTestRunner_hpp

#include "ut.UnitTestRunner.hpp"

namespace ut {

class GoogleTestRunner: public UnitTestRunner
{
public:
    // Implement UnitTestRunner interface
    virtual int execute( int argc, char **argv ) override;

}; // End class GoogleTestRunner

} // End namespace

#endif

// Classification: UNCLASSIFIED
