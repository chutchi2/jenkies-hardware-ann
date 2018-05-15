/*------------------------------------------------------------------------------
Filename: g11.RecursiveMutexImpl.hpp

Description:
OS abstraction for a recursive mutual exclusion lock.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_RecursiveMutexImpl_hpp
#define g11_RecursiveMutexImpl_hpp

#include "g11.MutexImpl.hpp"

namespace g11 {

class RecursiveMutexImpl: public MutexImpl
{
public:
    // Factory method for creating a recursive mutex
    static RecursiveMutexImpl* create();

    // Constructor/Destructor
    RecursiveMutexImpl(){}
    virtual ~RecursiveMutexImpl(){}

}; // End class RecursiveMutexImpl

} // End namespace

#endif
