/*------------------------------------------------------------------------------
Filename: g11.BinarySema.hpp

Description:
OS abstraction for a binary semaphore.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_BinarySema_hpp
#define g11_BinarySema_hpp

#include "g11.Sema.hpp"

namespace g11 {

class BinarySema: public Sema
{
public:
    // Constructor/Destructor
    explicit BinarySema( bool const isSignaled = false );
    virtual ~BinarySema();

private:
    DISALLOW_COPY_AND_ASSIGN( BinarySema );

}; // End class BinarySema

} // End namespace

#endif
