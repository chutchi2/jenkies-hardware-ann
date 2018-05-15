/*------------------------------------------------------------------------------
Filename: g11.BinarySemaImpl.hpp

Description:
OS abstraction for a binary semaphore.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_BinarySemaImpl_hpp
#define g11_BinarySemaImpl_hpp

#include "g11.SemaImpl.hpp"

namespace g11 {

class BinarySemaImpl: public SemaImpl
{
public:
    // Factory method for creating a binary semaphore
    static BinarySemaImpl* create( bool const isSignaled = false );

    // Constructor/Destructor
    BinarySemaImpl(){}
    virtual ~BinarySemaImpl(){}

}; // End class BinarySemaImpl

} // End namespace

#endif
