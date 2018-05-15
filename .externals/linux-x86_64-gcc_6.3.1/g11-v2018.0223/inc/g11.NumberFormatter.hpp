/*------------------------------------------------------------------------------
Filename: g11.NumberFormatter.hpp

Description:
Utility functions that format numbers into strings.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_NumberFormatter_hpp
#define g11_NumberFormatter_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class NumberFormatter
{
public:

    // Implement NumberFormatter interface
    static std::string append( std::string const &str, UINT32 const num );

private:
    DISALLOW_CTOR_AND_DTOR( NumberFormatter );
    DISALLOW_COPY_AND_ASSIGN( NumberFormatter );

}; // End class NumberFormatter

} // End namespace

#endif
