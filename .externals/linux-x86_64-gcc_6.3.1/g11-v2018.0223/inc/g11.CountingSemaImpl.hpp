/*------------------------------------------------------------------------------
Filename: g11.CountingSemaImpl.hpp

Description:
OS abstraction for a counting semaphore.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_CountingSemaImpl_hpp
#define g11_CountingSemaImpl_hpp

#include "g11.SemaImpl.hpp"

namespace g11 {

class CountingSemaImpl: public SemaImpl
{
public:
    // Factory method for creating a counting semaphore
    static CountingSemaImpl* create( UINT32 const initialCount = 0 );

    // Constructor/Destructor
    CountingSemaImpl(){}
    virtual ~CountingSemaImpl(){}

}; // End class CountingSemaImpl

} // End namespace

#endif
