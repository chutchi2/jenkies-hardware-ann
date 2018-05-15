/*------------------------------------------------------------------------------
Filename: g11.NoRecursionDiagnosticDecorator.hpp

Description:
Blocks recursion into a DiagnosticHandler.

This decorator returns without calling the decorated handler when a recursive
call is detected.

This class is not thread safe. Use a ThreadSafeDiagnosticDecorator to wrap this
decorator to make it thread safe.

Example:
MyDiagnosticHandler h;
NoRecursionDiagnosticDecorator r( h );
ThreadSafeDiagnosticDecorator t( r );
Diagnostics::instance().registerHandler( t );

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_NoRecursionDiagnosticDecorator_hpp
#define g11_NoRecursionDiagnosticDecorator_hpp

#include "g11.DiagnosticHandler.hpp"

namespace g11 {

class NoRecursionDiagnosticDecorator: public DiagnosticHandler
{
public:
    // Constructors/Destructors
    explicit NoRecursionDiagnosticDecorator( DiagnosticHandler * const pHandler );
    virtual ~NoRecursionDiagnosticDecorator();

    // Implement DiagnosticHandler interface
    virtual void info( std::string const &filename,
                       UINT32 const line,
                       std::string const &msg );

    virtual void warn( std::string const &filename, UINT32 const line );
    virtual void fatal( std::string const &filename, UINT32 const line );

private:
    DISALLOW_COPY_AND_ASSIGN( NoRecursionDiagnosticDecorator );

    DiagnosticHandler * const m_pHandler;
    bool m_isRecursive;

}; // End class NoRecursionDiagnosticDecorator

} // End namespace

#endif
