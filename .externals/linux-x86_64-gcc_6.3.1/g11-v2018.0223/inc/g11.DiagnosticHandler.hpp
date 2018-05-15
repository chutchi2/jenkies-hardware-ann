/*------------------------------------------------------------------------------
Filename: g11.DiagnosticHandler.hpp

Description:
Interface for handling diagnostic calls.

Thread Safety:
See Diagnostics class description.

Recursion:
See Diagnostics class description.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_DiagnosticHandler_hpp
#define g11_DiagnosticHandler_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class DiagnosticHandler
{
public:
    // Constructor/Destructor
    DiagnosticHandler(){}
    virtual ~DiagnosticHandler(){}

    // Define DiagnosticHandler interface
    virtual void info( std::string const &filename,
                       UINT32 const line,
                       std::string const &msg ) = 0;

    virtual void warn( std::string const &filename, UINT32 const line ) = 0;
    virtual void fatal( std::string const &filename, UINT32 const line ) = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( DiagnosticHandler );

}; // End class DiagnosticHandler

} // End namespace

#endif
