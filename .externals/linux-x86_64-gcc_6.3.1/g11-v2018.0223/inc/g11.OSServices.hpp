/*------------------------------------------------------------------------------
Filename: g11.OSServices.hpp

Description:
Abstract factory for creating and obtaining OS specific abstractions.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_OSServices_hpp
#define g11_OSServices_hpp

#include "g11.root.hpp"
#include "g11.ThreadImpl.hpp"
#include <string>

namespace g11 {

class BinarySemaImpl;
class CountingSemaImpl;
class CurrentThreadImpl;
class NonRecursiveMutexImpl;
class RecursiveMutexImpl;

class OSServices
{
public:
    // Implement singleton interface
    static OSServices& instance();

    // Constructors/Destructors
    OSServices(){}
    virtual ~OSServices(){}

    // Define OSServices interface
    virtual CurrentThreadImpl& getCurrentThread() = 0;

    virtual ThreadImpl* createThread( std::string const &threadName,
                                      ThreadImpl::EntryPoint * const pEntryPoint,
                                      void * const pArg ) = 0;

    virtual ThreadImpl* createThread( ThreadImpl::EntryPoint * const pEntryPoint,
                                      void * const pArg ) = 0;

    virtual NonRecursiveMutexImpl* createNonRecursiveMutex() = 0;
    virtual RecursiveMutexImpl*    createRecursiveMutex() = 0;

    virtual BinarySemaImpl*   createBinarySema( bool const isSignaled ) = 0;
    virtual CountingSemaImpl* createCountingSema( UINT32 const initialCount ) = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( OSServices );

}; // End class OSServices

} // End namespace

#endif
