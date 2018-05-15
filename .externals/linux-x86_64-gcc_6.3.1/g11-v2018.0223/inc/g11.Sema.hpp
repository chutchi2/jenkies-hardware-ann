/*------------------------------------------------------------------------------
Filename: g11.Sema.hpp

Description:
OS abstraction for a semaphore.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_Sema_hpp
#define g11_Sema_hpp

#include "g11.root.hpp"
#include "g11.SemaImpl.hpp"

namespace g11 {

class Sema
{
public:
    // Constructor/Destructor
    explicit Sema( SemaImpl &impl );
    virtual ~Sema();

    // Implement Sema interface
    virtual RetVal signal()  { return m_impl.signal(); }
    virtual RetVal request() { return m_impl.request(); }
    virtual RetVal wait()    { return m_impl.wait(); }

private:
    DISALLOW_COPY_AND_ASSIGN( Sema );

    SemaImpl &m_impl;

}; // End class Sema

} // End namespace

#endif
