/*------------------------------------------------------------------------------
 Filename: g11.NumberUtils.hpp

 Description:
 Provides utility functions for commonly used operations on numbers and boolean
 types.

 Copyright (c) 2017 discoversoft.org. All rights reserved.
 -----------------------------------------------------------------------------*/
#ifndef g11_NumberUtils_hpp
#define g11_NumberUtils_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class NumberUtils
{
public:

    enum Radix
    {
        AUTO    = 0,
        BINARY  = 2,
        OCTAL   = 8,
        DECIMAL = 10,
        HEX     = 16
    };

    // Implement NumberUtils interface

    // bool
    static RetVal parseStrict( std::string const &str, bool &val );
    static bool toValue( std::string const &str, bool const defVal );
    static std::string toString( bool const val );

    // double
    static RetVal parseStrict( std::string const &str, double &val );
    static double toValue( std::string const &str, double const defVal );
    static std::string toString( double const val );

    // INT32
    static RetVal parseStrict( std::string const &str, INT32 &val, UINT32 const base = DECIMAL );
    static INT32 toValue( std::string const &str, INT32 const defVal );
    static std::string toString( INT32 const val );

    // UINT32
    static RetVal parseStrict( std::string const &str, UINT32 &val, UINT32 const base = DECIMAL );
    static UINT32 toValue( std::string const &str, UINT32 const defVal );
    static std::string toString( UINT32 const val );

private:
    DISALLOW_CTOR_AND_DTOR( NumberUtils );
    DISALLOW_COPY_AND_ASSIGN( NumberUtils );

}; // End class NumberUtils

} // End namespace

#endif
