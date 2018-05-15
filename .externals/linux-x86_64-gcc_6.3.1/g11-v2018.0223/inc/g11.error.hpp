/*------------------------------------------------------------------------------
Filename: g11.error.hpp

Description:
Macros for error detection and handling.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_error_hpp
#define g11_error_hpp

#include "g11.types.hpp"
#include <string>

namespace g11 {

    void throwRuntimeError( std::string const &filename,
                            UINT32 const line,
                            std::string const &cond );

}

//------------------------------------------------------------------------------
// Throw std::runtime_error if [cond] is true
//------------------------------------------------------------------------------
#define THROW( cond )               \
    do                              \
    {                               \
        if( (cond) )                \
        {                           \
            g11::throwRuntimeError  \
                (                   \
                __FILE__,           \
                __LINE__,           \
                "'"#cond"'"         \
                );                  \
        }                           \
    } while( 0 );

//------------------------------------------------------------------------------
// Diagnostics
//------------------------------------------------------------------------------
#if defined( ENABLE_DIAGNOSTICS )
    #include "g11.diagnostic.hpp"
#elif defined( DISABLE_DIAGNOSTICS )
    #include "g11.nodiagnostic.hpp"
#endif

//------------------------------------------------------------------------------
// Asserts
//------------------------------------------------------------------------------
#if defined( ENABLE_ASSERT )
    #include "g11.assert.hpp"
#elif defined( DISABLE_ASSERT )
    #include "g11.noassert.hpp"
#endif

//------------------------------------------------------------------------------
// Preconditions and Postconditions
//------------------------------------------------------------------------------
#if defined( ENABLE_ASSERT )
    #define PRECONDITION( cond )  G11_ASSERT_TRUE( cond )
    #define POSTCONDITION( cond ) G11_ASSERT_TRUE( cond )
#elif defined( ENABLE_DIAGNOSTICS )
    #define PRECONDITION( cond )  FATAL( !(cond) )
    #define POSTCONDITION( cond ) FATAL( !(cond) )
#else
    #define PRECONDITION( cond )
    #define POSTCONDITION( cond )
#endif

#endif
