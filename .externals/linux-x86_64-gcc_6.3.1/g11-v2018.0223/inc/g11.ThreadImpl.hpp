/*------------------------------------------------------------------------------
Filename: g11.ThreadImpl.hpp

Description:
OS abstraction for a thread.

The terms activate and deactivate are used to avoid confusion with the Thread
class, which uses the terms run and stop. The activate() and deactivate()
methods are used only in the context of OS specific abstractions. The run() and
stop() methods are used in OS independent abstractions.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_ThreadImpl_hpp
#define g11_ThreadImpl_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class ThreadImpl
{
public:
    // Prototype for a thread's entry point function
    typedef void (EntryPoint)( void *pArg );

    // Factory methods for creating an OS specific thread
    static ThreadImpl* create( std::string const &threadName,
                               EntryPoint * const pEntryPoint,
                               void * const pArg );

    static ThreadImpl* create( EntryPoint * const pEntryPoint,
                               void * const pArg );

    // Constructors/Destructors
    ThreadImpl(){}
    virtual ~ThreadImpl(){}

    // Define ThreadImpl interface
    virtual RetVal activate() = 0;
    virtual RetVal deactivate() = 0;
    virtual RetVal join() = 0;

    virtual bool isActive() const = 0;
    virtual UINT32 getThreadID() const = 0;
    virtual std::string const & getThreadName() const = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( ThreadImpl );

}; // End class ThreadImpl

} // End namespace

#endif
