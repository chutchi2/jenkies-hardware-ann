/*------------------------------------------------------------------------------
Filename: g11.Usage.hpp

Description:
Interface for implementing various command line usages.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_Usage_hpp
#define g11_Usage_hpp

#include "g11.root.hpp"

namespace g11 {

class CmdLineArgs;

class Usage
{
public:
    // Constructors/Destructors
    Usage(){}
    virtual ~Usage(){}

    // Define Usage interface
    virtual RetVal validate( CmdLineArgs const &args )
    {
        UNUSED( args );
        return RV_OK;
    }

    virtual RetVal execute( CmdLineArgs const &args ) = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( Usage );

}; // End class Usage

} // End namespace

#endif
