/*------------------------------------------------------------------------------
Filename: g11.Diagnostics.hpp

Description:
Defines a basic diagnostic capability.

Thread Safety:
There are two levels of thread safety in relation to this class.

The first level of thread safety has to do with registering the handler.
Registering the handler using this class directly is not thread safe. Use an
instance of DiagnosticHandlers to register a handler in a thread safe manner.

The second level of thread safety has to do with the actual handlers. The thread
safety of the log(), warn(), and fatal() methods depend on each handlers'
implementation. In general, handlers are not thread safe. You can make a handler
thread safe by using an instance of DiagnosticHandlers and specifying the
makeThreadSafe() attribute when registering a handler.

Recursion:
It is likely that a diagnostic handler will rely on code that uses the
diagnostic macros which, in turn, may call back into the diagnostic handler.
This may result in an endless loop if an error occurs within the handler chain
of events. You can prevent recursion by using an instance of DiagnosticHandlers
and specifying the blockRecursion() attribute when registering a handler.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_Diagnostics_hpp
#define g11_Diagnostics_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class DiagnosticHandler;

class Diagnostics
{
public:
    // Implement singleton interface
    static Diagnostics& instance();

    // Constructors/Destructors
    Diagnostics();
    ~Diagnostics();

    // Implement Diagnostics interface
    void registerHandler( DiagnosticHandler * const pHandler );
    void resetHandler();

    void info( std::string const &filename,
               UINT32 const line,
               std::string const &msg );

    void warn( std::string const &filename, UINT32 const line );
    void fatal( std::string const &filename, UINT32 const line );

private:
    DISALLOW_COPY_AND_ASSIGN( Diagnostics );

    DiagnosticHandler *m_pHandler;

}; // End class Diagnostics

} // End namespace

#endif
