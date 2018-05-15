/*------------------------------------------------------------------------------
Filename: g11.RecursiveMutex.hpp

Description:
OS abstraction for a recursive mutual exclusion lock.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_RecursiveMutex_hpp
#define g11_RecursiveMutex_hpp

#include "g11.Mutex.hpp"

namespace g11 {

class RecursiveMutex: public Mutex
{
public:
    // Constructor/Destructor
    RecursiveMutex();
    virtual ~RecursiveMutex();

private:
    DISALLOW_COPY_AND_ASSIGN( RecursiveMutex );

}; // End class RecursiveMutex

} // End namespace

#endif
