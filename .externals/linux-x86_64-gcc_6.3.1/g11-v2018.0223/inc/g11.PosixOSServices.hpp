/*------------------------------------------------------------------------------
Filename: g11.PosixOSServices.hpp

Description:
Posix implementation of various OS abstractions.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_PosixOSServices_hpp
#define g11_PosixOSServices_hpp

#include "g11.OSServices.hpp"

namespace g11 {

class PosixOSServices: public OSServices
{
public:
    // Constructors/Destructors
    PosixOSServices();
    virtual ~PosixOSServices();

    // Implement OSServices interface
    virtual CurrentThreadImpl& getCurrentThread();

    virtual ThreadImpl* createThread( std::string const &threadName,
                                      ThreadImpl::EntryPoint * const pEntryPoint,
                                      void * const pArg );

    virtual ThreadImpl* createThread( ThreadImpl::EntryPoint * const pEntryPoint,
                                      void * const pArg );

    virtual NonRecursiveMutexImpl* createNonRecursiveMutex();
    virtual RecursiveMutexImpl*    createRecursiveMutex();

    virtual BinarySemaImpl*   createBinarySema( bool const isSignaled );
    virtual CountingSemaImpl* createCountingSema( UINT32 const initialCount );

private:
    DISALLOW_COPY_AND_ASSIGN( PosixOSServices );

}; // End class PosixOSServices

} // End namespace

#endif
