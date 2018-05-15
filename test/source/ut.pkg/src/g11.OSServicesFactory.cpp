/*------------------------------------------------------------------------------
Filename: g11.OSServicesFactory.cpp

Description:
Factory class for returning an implementation of OSServices.

This class declares a single static function for returning a concrete
implementation of OSServices. This method must be implemented by the user.

A recommended implementation may look like the following:

#include <g11.PosixOSServices.hpp>

OSServices& OSServicesFactory::getOSServices()
{
    static PosixOSServices &instance = *new PosixOSServices;
    return instance;
}

Placing the instance in a function level static variable will eliminate certain
initialization order problems that can happen if the function is called before
main().

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#include <g11.OSServicesFactory.hpp>
#include <g11.PosixOSServices.hpp>

using namespace g11;

/*------------------------------------------------------------------------------
Return an instance of OSServices.

Parameters:
None

Return Value:
An instance of OSServices.
------------------------------------------------------------------------------*/
// static
OSServices& OSServicesFactory::getOSServices()
{
    static PosixOSServices instance;
    return instance;
}
