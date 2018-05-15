/*------------------------------------------------------------------------------
 Filename: GatesAbstractFactory.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef GatesAbstractFactory_hpp
#define GatesAbstractFactory_hpp

#include "IGate.cpp"
#include "GateTypes.hpp"

class GatesAbstractFactory
{
public:
    IGate getGate( EGateTypes id );
};
#endif
