/*------------------------------------------------------------------------------
Filename: g11.CurrentThread.hpp

Description:
OS abstraction for operations that can be performed on the current thread.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_CurrentThread_hpp
#define g11_CurrentThread_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class CurrentThread
{
public:
    // Implement CurrentThread interface
    static void sleep( UINT32 const milliseconds );
    static RetVal yield();

    static UINT32 getThreadID();
    static std::string const & getThreadName();

private:
    DISALLOW_CTOR_AND_DTOR( CurrentThread );

}; // End class CurrentThread

} // End namespace

#endif
