/*------------------------------------------------------------------------------
Filename: g11.NullDiagnosticHandler.hpp

Description:
A null implementation of the DiagnosticHandler interface.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_NullDiagnosticHandler_hpp
#define g11_NullDiagnosticHandler_hpp

#include "g11.DiagnosticHandler.hpp"

namespace g11 {

class NullDiagnosticHandler: public DiagnosticHandler
{
public:
    // Constructor/Destructor
    NullDiagnosticHandler(){}
    virtual ~NullDiagnosticHandler(){}

    // Implement DiagnosticHandler interface
    virtual void info( std::string const &filename,
                       UINT32 const line,
                       std::string const &msg )
    {
        UNUSED( filename );
        UNUSED( line );
        UNUSED( msg );
    }

    virtual void warn( std::string const &filename, UINT32 const line )
    {
        UNUSED( filename );
        UNUSED( line );
    }

    virtual void fatal( std::string const &filename, UINT32 const line )
    {
        UNUSED( filename );
        UNUSED( line );
    }

}; // End class NullDiagnosticHandler

} // End namespace

#endif
