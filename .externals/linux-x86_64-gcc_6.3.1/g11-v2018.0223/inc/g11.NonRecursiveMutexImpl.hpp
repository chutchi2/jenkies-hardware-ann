/*------------------------------------------------------------------------------
Filename: g11.NonRecursiveMutexImpl.hpp

Description:
OS abstraction for a non-recursive mutual exclusion lock.

A non-recursive mutex can be faster than a recursive mutex.

If a specific platform does not support non-recursive mutex locks, it will be
implemented using a recursive mutex lock. This will allow platform independent
code to be written and still benefit from a non-recursive mutex lock when it is
available.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_NonRecursiveMutexImpl_hpp
#define g11_NonRecursiveMutexImpl_hpp

#include "g11.MutexImpl.hpp"

namespace g11 {

class NonRecursiveMutexImpl: public MutexImpl
{
public:
    // Factory method for creating a non-recursive mutex
    static NonRecursiveMutexImpl* create();

    // Constructor/Destructor
    NonRecursiveMutexImpl(){}
    virtual ~NonRecursiveMutexImpl(){}

}; // End class NonRecursiveMutexImpl

} // End namespace

#endif
