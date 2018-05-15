/*------------------------------------------------------------------------------
Filename: g11.MutexImpl.hpp

Description:
OS abstraction for a mutual exclusion lock.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_MutexImpl_hpp
#define g11_MutexImpl_hpp

#include "g11.root.hpp"

namespace g11 {

class MutexImpl
{
public:
    // Constructor/Destructor
    MutexImpl(){}
    virtual ~MutexImpl(){}

    // Define MutexImpl interface
    virtual RetVal tryLock() = 0;
    virtual RetVal lock() = 0;
    virtual RetVal unlock() = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( MutexImpl );

}; // End class MutexImpl

} // End namespace

#endif
