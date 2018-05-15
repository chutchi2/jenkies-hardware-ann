// Classification: UNCLASSIFIED

/*------------------------------------------------------------------------------
Filename: ut.UnitTestRunner.hpp

Description:
Initializes and executes unit tests.

Copyright (c) 2017 Cosmic AES. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef ut_UnitTestRunner_hpp
#define ut_UnitTestRunner_hpp

#include "ut.root.hpp"

namespace ut {

class UnitTestRunner
{
public:
    // Object management
    UnitTestRunner() = default;
    virtual ~UnitTestRunner() = default;
    DISALLOW_COPY_AND_MOVE_OPERATIONS( UnitTestRunner );

    // Define UnitTestRunner interface
    virtual int execute( int argc, char **argv ) = 0;
    void registerConsoleHandler();

}; // End class UnitTestRunner

} // End namespace

#endif

// Classification: UNCLASSIFIED
