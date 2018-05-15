/*------------------------------------------------------------------------------
Filename: g11.ThreadRunner.hpp

Description:
Executes a function within its own thread.

Thread Safety:
While the operations of this class are thread safe with respect to the thread
being controlled, the class is not itself thread safe. This means that the
methods defined in this class cannot be called simultaneously among multiple
threads. As a consequence, only a single thread at a time may call join() or any
other method in this class.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_ThreadRunner_hpp
#define g11_ThreadRunner_hpp

#include "g11.root.hpp"
#include "g11.ThreadImpl.hpp"
#include <string>

namespace g11 {

class ThreadRunner
{
public:
    // Implement ThreadRunner static interface
    typedef ThreadImpl::EntryPoint EntryPoint;
    static ThreadRunner* run( EntryPoint * const pEntryPoint, void *pArg = 0 );

    // Constructors/Destructors
    explicit ThreadRunner( EntryPoint * const pEntryPoint, void *pArg = 0 );
    ~ThreadRunner();

    // Implement ThreadRunner interface
    RetVal run();
    RetVal kill();
    RetVal join();

    bool isRunning() const;
    UINT32 getThreadID() const;
    std::string const & getThreadName() const;

private:
    DISALLOW_COPY_AND_ASSIGN( ThreadRunner );

    ThreadImpl &m_impl;

}; // End class ThreadRunner

} // End namespace

#endif
