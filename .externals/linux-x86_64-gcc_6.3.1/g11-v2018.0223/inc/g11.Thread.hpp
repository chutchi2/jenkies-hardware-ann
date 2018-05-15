/*------------------------------------------------------------------------------
Filename: g11.Thread.hpp

Description:
Interface for a thread.

Thread Safety:
While the operations of this class are thread safe with respect to the thread
being controlled, the class is not itself thread safe. This means that the
methods defined in this class cannot be called simultaneously among multiple
threads. As a consequence, only a single thread at a time may call join() or any
other method in this class.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_Thread_hpp
#define g11_Thread_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class ThreadImpl;

class Thread
{
public:
    // Constructors/Destructors
    Thread();
    explicit Thread( std::string const &threadName );
    virtual ~Thread();

    // Implement Thread interface
    RetVal start();
    RetVal stop();
    RetVal kill();
    RetVal join();

    bool isRunning() const;
    UINT32 getThreadID() const;
    std::string const & getThreadName() const;

protected:
    virtual RetVal requestStop() = 0;
    virtual void run() = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( Thread );

    // Entry point for the thread
    static void entryPoint( void *pArg );

    ThreadImpl &m_impl;

}; // End class Thread

} // End namespace

#endif
