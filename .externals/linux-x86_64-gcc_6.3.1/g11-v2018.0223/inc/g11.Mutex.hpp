/*------------------------------------------------------------------------------
Filename: g11.Mutex.hpp

Description:
OS abstraction for a mutual exclusion lock.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_Mutex_hpp
#define g11_Mutex_hpp

#include "g11.root.hpp"
#include "g11.MutexImpl.hpp"

namespace g11 {

class Mutex
{
public:
    // Constructor/Destructor
    explicit Mutex( MutexImpl &impl );
    virtual ~Mutex();

    // Implement Mutex interface
    virtual RetVal tryLock() { return m_impl.tryLock(); }
    virtual RetVal lock()    { return m_impl.lock(); }
    virtual RetVal unlock()  { return m_impl.unlock(); }

private:
    DISALLOW_COPY_AND_ASSIGN( Mutex );

    MutexImpl &m_impl;

}; // End class Mutex

} // End namespace

#endif
