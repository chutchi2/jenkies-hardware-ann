/*------------------------------------------------------------------------------
Filename: g11.log.hpp

Description:
Macros for logging.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_log_hpp
#define g11_log_hpp

#if defined( ENABLE_IO )

    #include "g11.Diagnostics.hpp"
    #include <iomanip>
    #include <iostream>
    #include <sstream>

    //--------------------------------------------------------------------------
    // Send a log entry using the given stream
    //--------------------------------------------------------------------------
    #define G11_LOG( stream )                   \
        do                                      \
        {                                       \
            std::stringstream ss;               \
            ss << stream;                       \
            g11::Diagnostics::instance().info   \
                (                               \
                __FILE__,                       \
                __LINE__,                       \
                ss.str()                        \
                );                              \
        } while( 0 )

    //--------------------------------------------------------------------------
    // Print a value
    //--------------------------------------------------------------------------
    #define G11_LOG_VALUE( var )                \
        do                                      \
        {                                       \
            std::stringstream ss;               \
            ss << #var" = " << var;             \
            g11::Diagnostics::instance().info   \
                (                               \
                __FILE__,                       \
                __LINE__,                       \
                ss.str()                        \
                );                              \
        } while( 0 )

    //--------------------------------------------------------------------------
    // Print a value in hex
    //--------------------------------------------------------------------------
    #define G11_LOG_HEX_VALUE( var )            \
        do                                      \
        {                                       \
            std::stringstream ss;               \
            ss << #var" = 0x"                   \
               << std::setfill( '0' )           \
               << std::setw( 8 )                \
               << std::hex                      \
               << var;                          \
            g11::Diagnostics::instance().info   \
                (                               \
                __FILE__,                       \
                __LINE__,                       \
                ss.str()                        \
                );                              \
        } while( 0 )

#elif defined( DISABLE_IO )

    #define G11_LOG( stream ) do{} while( 0 )
    #define G11_LOG_VALUE( stream ) do{} while( 0 )
    #define G11_LOG_HEX_VALUE( stream ) do{} while( 0 )

#endif // ENABLE_IO

#endif
