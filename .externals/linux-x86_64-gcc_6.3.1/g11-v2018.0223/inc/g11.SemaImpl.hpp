/*------------------------------------------------------------------------------
Filename: g11.SemaImpl.hpp

Description:
OS abstraction for a semaphore.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_SemaImpl_hpp
#define g11_SemaImpl_hpp

#include "g11.root.hpp"

namespace g11 {

class SemaImpl
{
public:
    // Constructor/Destructor
    SemaImpl(){}
    virtual ~SemaImpl(){}

    // Define SemaImpl interface
    virtual RetVal signal() = 0;
    virtual RetVal request() = 0;
    virtual RetVal wait() = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( SemaImpl );

}; // End class SemaImpl

} // End namespace

#endif
