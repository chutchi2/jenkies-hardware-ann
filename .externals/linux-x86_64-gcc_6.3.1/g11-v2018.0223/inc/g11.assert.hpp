/*------------------------------------------------------------------------------
Filename: g11.assert.hpp

Description:
Macros for various assert definitions.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_assert_hpp
#define g11_assert_hpp

#include "g11.types.hpp"
#include <string>

namespace g11 {

    void g11Assert( std::string const &filename,
                    UINT32 const line,
                    std::string const &msg );

}

//------------------------------------------------------------------------------
// Function that will be applied to all asserts
//------------------------------------------------------------------------------
#define ASSERT_FN( cond, msg )    \
    do                            \
    {                             \
        g11::g11Assert            \
            (                     \
            __FILE__,             \
            __LINE__,             \
            "'" #cond "' " msg    \
            );                    \
    } while( 0 )

//------------------------------------------------------------------------------
// ASSERT Macros
//------------------------------------------------------------------------------
#define G11_ASSERT_TRUE( cond ) \
    if( !(cond) ) { ASSERT_FN( cond, "is not true" ); } else (void) 0

#define G11_ASSERT_FALSE( cond ) \
    if( (cond) ) { ASSERT_FN( cond, "is not false" ); } else (void) 0

#define G11_ASSERT_ZERO( cond ) \
    if( (cond) != 0 ) { ASSERT_FN( cond, " != 0" ); } else (void) 0

#define G11_ASSERT_NOT_ZERO( cond ) \
    if( (cond) == 0 ) { ASSERT_FN( cond, " == 0" ); } else (void) 0

#define G11_ASSERT_NULL( cond ) \
    if( (cond) != 0 ) { ASSERT_FN( cond, "is not null" ); } else (void) 0

#define G11_ASSERT_NOT_NULL( cond ) \
    if( (cond) == 0 ) { ASSERT_FN( cond, "is null" ); } else (void) 0

#endif
