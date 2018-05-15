/*------------------------------------------------------------------------------
Filename: g11.ThreadSafeDiagnosticDecorator.hpp

Description:
Adds thread safety to a DiagnosticHandler.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_ThreadSafeDiagnosticDecorator_hpp
#define g11_ThreadSafeDiagnosticDecorator_hpp

#include "g11.DiagnosticHandler.hpp"
#include "g11.RecursiveMutex.hpp"

namespace g11 {

class ThreadSafeDiagnosticDecorator: public DiagnosticHandler
{
public:
    // Constructors/Destructors
    explicit ThreadSafeDiagnosticDecorator( DiagnosticHandler * const pHandler );
    virtual ~ThreadSafeDiagnosticDecorator();

    // Implement DiagnosticHandler interface
    virtual void info( std::string const &filename,
                       UINT32 const line,
                       std::string const &msg );

    virtual void warn( std::string const &filename, UINT32 const line );
    virtual void fatal( std::string const &filename, UINT32 const line );

private:
    DISALLOW_COPY_AND_ASSIGN( ThreadSafeDiagnosticDecorator );

    RecursiveMutex m_mutex;
    DiagnosticHandler * const m_pHandler;

}; // End class ThreadSafeDiagnosticDecorator

} // End namespace

#endif
