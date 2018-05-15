/*------------------------------------------------------------------------------
Filename: g11.Service.hpp

Description:
A simple service abstraction.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_Service_hpp
#define g11_Service_hpp

#include "g11.root.hpp"

namespace g11 {

class Service
{
public:
    // Constructors/Destructors
    Service(){}
    virtual ~Service(){}

    // Define Service interface
    virtual RetVal start() = 0;
    virtual RetVal stop() = 0;

private:
    DISALLOW_COPY_AND_ASSIGN( Service );

}; // End class Service

} // End namespace

#endif
