/*------------------------------------------------------------------------------
Filename: g11.ConsoleDiagnosticHandler.hpp

Description:
Implements a diagnostic handler by writing to the console.

This class is not thread safe.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_ConsoleDiagnosticHandler_hpp
#define g11_ConsoleDiagnosticHandler_hpp

#include "g11.DiagnosticHandler.hpp"

namespace g11 {

class ConsoleDiagnosticHandler: public DiagnosticHandler
{
public:
    // Constructor/Destructor
    ConsoleDiagnosticHandler();
    virtual ~ConsoleDiagnosticHandler();

    // Implement DiagnosticHandler interface
    virtual void info( std::string const &filename,
                       UINT32 const line,
                       std::string const &msg );

    virtual void warn( std::string const &filename, UINT32 const line );
    virtual void fatal( std::string const &filename, UINT32 const line );

private:
    void print( std::string const &label,
                std::string const &filename,
                UINT32 const line,
                std::string const &msg = "" );

}; // End class ConsoleDiagnosticHandler

} // End namespace

#endif
