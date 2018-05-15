/*------------------------------------------------------------------------------
Filename: g11.nodiagnostic.hpp

Description:
Macros for using basic diagnostic capabilities.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_nodiagnostic_hpp
#define g11_nodiagnostic_hpp

//------------------------------------------------------------------------------
// Diagnostic macros
//------------------------------------------------------------------------------
#define INFO( cond )  do{} while( 0 )
#define WARN( cond )  do{} while( 0 )
#define FATAL( cond ) do{} while( 0 )

#define WARN_AND_RETURN( cond, ret ) \
    do{ if( cond ) return ret; } while( 0 )

#define WARN_AND_THROW( cond ) \
    do{ if( cond ) THROW( cond ); } while( 0 )

#endif
