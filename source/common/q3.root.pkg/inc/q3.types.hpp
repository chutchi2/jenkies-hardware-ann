/*------------------------------------------------------------------------------
Filename: q3.types.hpp

Description:
Common type definitions.

DO NOT PUT CONFIGURATION DATA HERE.
------------------------------------------------------------------------------*/
#ifndef q3_types_hpp
#define q3_types_hpp

#include <stdint.h>

//------------------------------------------------------------------------------
// Global Convenience Macros
//------------------------------------------------------------------------------
#define DISALLOW_INSTANTIATION( T )                 \
    T() = delete;                                   \
    ~T() = delete

#define DISALLOW_COPY_OPERATIONS( T )               \
    T( const T& ) = delete;                         \
    T& operator=( const T& ) = delete

#define DISALLOW_MOVE_OPERATIONS( T )               \
    T( T&& ) = delete;                              \
    T& operator=( T&& ) = delete

#define DISALLOW_COPY_AND_MOVE_OPERATIONS( T )      \
    DISALLOW_COPY_OPERATIONS( T );                  \
    DISALLOW_MOVE_OPERATIONS( T )

#define ALLOW_DEFAULT_COPY_OPERATIONS( T )          \
    T( const T& ) = default;                        \
    T& operator=( const T& ) = default

#define ALLOW_DEFAULT_MOVE_OPERATIONS( T )          \
    T( T&& ) = default;                             \
    T& operator=( T&& ) = default

#define ALLOW_DEFAULT_COPY_AND_MOVE_OPERATIONS( T ) \
    ALLOW_DEFAULT_COPY_OPERATIONS( T );             \
    ALLOW_DEFAULT_MOVE_OPERATIONS( T )

#endif
