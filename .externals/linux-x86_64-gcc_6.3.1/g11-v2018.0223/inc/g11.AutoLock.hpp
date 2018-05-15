/*------------------------------------------------------------------------------
Filename: g11.AutoLock.hpp

Description:
Mutex resource wrapper to automate locking and unlocking.

This is an implementation of RAII (Resource Allocation Is Initialization) where
the constructor locks the mutex and the destructor unlocks the mutex.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_AutoLock_hpp
#define g11_AutoLock_hpp

#include "g11.root.hpp"
#include "g11.Mutex.hpp"

namespace g11 {

class AutoLock
{
public:
    // Constructor/Destructor
    explicit AutoLock( Mutex &mutex ):
    m_mutex( mutex )
    {
        m_mutex.lock();
    }

    ~AutoLock()
    {
        m_mutex.unlock();
    }

private:
    DISALLOW_COPY_AND_ASSIGN( AutoLock );

    Mutex &m_mutex;

}; // End class AutoLock

} // End namespace

#endif
