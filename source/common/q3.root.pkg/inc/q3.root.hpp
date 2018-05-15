/*------------------------------------------------------------------------------
Filename: q3.root.hpp

Description:
This file is intended to be included by most other files. It makes the root type
definitions, error handling macros, and logging macros immediately available to
every file that includes it.

Dependencies are very carefully managed. Only the absolute minimum of
dependencies and dependencies that are stable (unchanging) are included here.

DO NOT PUT CONFIGURATION DATA HERE.
------------------------------------------------------------------------------*/
#ifndef q3_root_hpp
#define q3_root_hpp

#include <g11.root.hpp>
#include "q3.types.hpp"

namespace q3
{
    using namespace g11;
}

#endif
