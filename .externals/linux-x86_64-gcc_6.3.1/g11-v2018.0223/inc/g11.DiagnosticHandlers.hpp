/*------------------------------------------------------------------------------
Filename: g11.DiagnosticHandlers.hpp

Description:
Builder for diagnostic handlers.

In addition to being able to apply attributes to a handler, this class also
provides a thread safe way to register a handler, provided all handlers are
registered through an instance of this class. When registering a handler, it
does not have to be the same instance in order to be thread safe.

Example Usage:
#include "g11.DiagnosticHandlers.hpp"
DiagnosticHandlers builder;
builder.blockRecursion()
       .makeThreadSafe()
       .registerConsoleHandler();

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_DiagnosticHandlers_hpp
#define g11_DiagnosticHandlers_hpp

#include "g11.root.hpp"

namespace g11 {

class DiagnosticHandler;

class DiagnosticHandlers
{
public:
    // Constructors/Destructors
    DiagnosticHandlers();
    ~DiagnosticHandlers();

    // Implement DiagnosticHandlers interface
    void registerConsoleHandler();
    void registerHandler( DiagnosticHandler * const pHandler );

    // Apply attributes
    DiagnosticHandlers& blockRecursion();
    DiagnosticHandlers& makeThreadSafe();

private:
    DISALLOW_COPY_AND_ASSIGN( DiagnosticHandlers );

    DiagnosticHandler* makeHandler( DiagnosticHandler * const pBase );

    bool m_blockRecursion;
    bool m_makeThreadSafe;

}; // End class DiagnosticHandlers

} // End namespace

#endif
