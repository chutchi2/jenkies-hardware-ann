/*------------------------------------------------------------------------------
Filename: g11.types.hpp

Description:
Common type definitions.

DO NOT PUT CONFIGURATION DATA HERE.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_types_hpp
#define g11_types_hpp

namespace g11 {

//---------------------------------------------------------------------------
// Platform Specific Types
//---------------------------------------------------------------------------
// Floats
typedef float   FLOAT32;
typedef double  FLOAT64;

// Signed integers
typedef signed char          INT8;
typedef signed short int     INT16;
typedef signed int           INT32;
typedef signed long long int INT64;

// Unsigned integers
typedef unsigned char          UINT8;
typedef unsigned short int     UINT16;
typedef unsigned int           UINT32;
typedef unsigned long long int UINT64;


//---------------------------------------------------------------------------
// Globally Defined Types
//---------------------------------------------------------------------------
// Global return values
enum RetVal
{
    RV_OK = 0,
    RV_FAIL,
    RV_ERROR,
    RV_TIMEOUT
};

} // End namespace


//------------------------------------------------------------------------------
// Global Convenience Macros
//------------------------------------------------------------------------------
// Ensure portability between processors/compilers that use different size_t
// values.
#define SIZE_IN_BYTES( Type ) ( sizeof( Type ) )

// Disable constructor and destructor
#define DISALLOW_CTOR_AND_DTOR( T )  \
    T();                             \
    ~T()

// Disable copy constructor and assignment operator
#define DISALLOW_COPY_AND_ASSIGN( T )  \
    T( const T& );                     \
    T& operator=( const T& )

// Disable new and delete
#define DISALLOW_NEW_AND_DELETE( T ) \
    void* operator new( size_t );    \
    void* operator new[]( size_t );  \
    void operator delete( void *);   \
    void operator delete[]( void *)

// Declare a variable as used/unused.
// These are functionally the same thing.
#define USED( var )   ((void)(var))
#define UNUSED( var ) ((void)(var))

#endif
