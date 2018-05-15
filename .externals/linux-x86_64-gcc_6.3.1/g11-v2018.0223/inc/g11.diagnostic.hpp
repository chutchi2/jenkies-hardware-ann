/*------------------------------------------------------------------------------
Filename: g11.diagnostic.hpp

Description:
Macros for using basic diagnostic capabilities.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_diagnostic_hpp
#define g11_diagnostic_hpp

#include "g11.Diagnostics.hpp"

//------------------------------------------------------------------------------
// Report if [cond] is true
//------------------------------------------------------------------------------
#define INFO( cond )                            \
    do                                          \
    {                                           \
        if( cond )                              \
        {                                       \
            g11::Diagnostics::instance().info   \
                (                               \
                __FILE__,                       \
                __LINE__,                       \
                ""                              \
                );                              \
        }                                       \
    } while( 0 )

//------------------------------------------------------------------------------
// Warn if [cond] is true
//------------------------------------------------------------------------------
#define WARN( cond )                            \
    do                                          \
    {                                           \
        if( cond )                              \
        {                                       \
            g11::Diagnostics::instance().warn   \
                (                               \
                __FILE__,                       \
                __LINE__                        \
                );                              \
        }                                       \
    } while( 0 )

//------------------------------------------------------------------------------
// Warn and return [ret] if [cond] is true
//------------------------------------------------------------------------------
#define WARN_AND_RETURN( cond, ret )            \
    do                                          \
    {                                           \
        if( cond )                              \
        {                                       \
            g11::Diagnostics::instance().warn   \
                (                               \
                __FILE__,                       \
                __LINE__                        \
                );                              \
            return ret;                         \
        }                                       \
    } while( 0 )

//------------------------------------------------------------------------------
// Warn and throw std::runtime_error if [cond] is true
//------------------------------------------------------------------------------
#define WARN_AND_THROW( cond )                  \
    do                                          \
    {                                           \
        if( cond )                              \
        {                                       \
            g11::Diagnostics::instance().warn   \
                (                               \
                __FILE__,                       \
                __LINE__                        \
                );                              \
            THROW( cond );                      \
        }                                       \
    } while( 0 )

//------------------------------------------------------------------------------
// Halt if [cond] is true
//------------------------------------------------------------------------------
#define FATAL( cond )                           \
    do                                          \
    {                                           \
        if( cond )                              \
        {                                       \
            g11::Diagnostics::instance().fatal  \
                (                               \
                __FILE__,                       \
                __LINE__                        \
                );                              \
        }                                       \
    } while( 0 )

#endif
