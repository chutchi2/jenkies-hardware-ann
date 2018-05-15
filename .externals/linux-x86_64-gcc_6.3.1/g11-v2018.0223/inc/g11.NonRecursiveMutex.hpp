/*------------------------------------------------------------------------------
Filename: g11.NonRecursiveMutex.hpp

Description:
OS abstraction for a non-recursive mutual exclusion lock.

A non-recursive mutex can be faster than a recursive mutex.

If a specific platform does not support non-recursive mutex locks, it will be
implemented using a recursive mutex lock. This will allow platform independent
code to be written and still benefit from a non-recursive mutex lock when it is
available.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_NonRecursiveMutex_hpp
#define g11_NonRecursiveMutex_hpp

#include "g11.Mutex.hpp"

namespace g11 {

class NonRecursiveMutex: public Mutex
{
public:
    // Constructor/Destructor
    NonRecursiveMutex();
    virtual ~NonRecursiveMutex();

private:
    DISALLOW_COPY_AND_ASSIGN( NonRecursiveMutex );

}; // End class NonRecursiveMutex

} // End namespace

#endif
