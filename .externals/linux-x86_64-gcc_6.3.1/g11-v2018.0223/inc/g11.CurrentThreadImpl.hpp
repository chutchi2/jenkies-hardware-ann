/*------------------------------------------------------------------------------
Filename: g11.CurrentThreadImpl.hpp

Description:
OS abstraction for operations that can be performed on the current thread.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_CurrentThreadImpl_hpp
#define g11_CurrentThreadImpl_hpp

#include "g11.root.hpp"
#include <string>

namespace g11 {

class CurrentThreadImpl
{
public:
    // Implement singleton interface
    static CurrentThreadImpl& instance();

    // Constructors/Destructors
    CurrentThreadImpl(){}
    virtual ~CurrentThreadImpl(){}

    // Define CurrentThreadImpl interface
    virtual void sleep( UINT32 const milliseconds ) = 0;
    virtual RetVal yield() = 0;

    virtual UINT32 getThreadID() = 0;
    virtual std::string const & getThreadName() = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( CurrentThreadImpl );

}; // End class CurrentThreadImpl

} // End namespace

#endif
