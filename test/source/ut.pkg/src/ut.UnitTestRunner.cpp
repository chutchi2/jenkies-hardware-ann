// Classification: UNCLASSIFIED

/*------------------------------------------------------------------------------
Filename: ut.UnitTestRunner.cpp

Description:
Initializes and executes unit tests.
------------------------------------------------------------------------------*/
#include "ut.UnitTestRunner.hpp"
#include <g11.DiagnosticHandlers.hpp>

using namespace ut;

//------------------------------------------------------------------------------
void UnitTestRunner::registerConsoleHandler()
{
    DiagnosticHandlers h;

    h.blockRecursion()
     .makeThreadSafe()
     .registerConsoleHandler();
}

// Classification: UNCLASSIFIED
