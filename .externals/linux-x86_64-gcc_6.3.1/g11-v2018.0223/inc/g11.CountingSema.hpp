/*------------------------------------------------------------------------------
Filename: g11.CountingSema.hpp

Description:
OS abstraction for a counting semaphore.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_CountingSema_hpp
#define g11_CountingSema_hpp

#include "g11.Sema.hpp"

namespace g11 {

class CountingSema: public Sema
{
public:
    // Constructor/Destructor
    explicit CountingSema( UINT32 const initialCount = 0 );
    virtual ~CountingSema();

private:
    DISALLOW_COPY_AND_ASSIGN( CountingSema );

}; // End class CountingSema

} // End namespace

#endif
