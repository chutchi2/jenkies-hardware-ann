/*------------------------------------------------------------------------------
 Filename: GateFactory.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef GateFactory_hpp
#define GateFactory_hpp

#include "IGate.hpp"
#include "GateTypes.hpp"

class GateFactory: public GatesAbstractFactory
{
public:
    IGate getGate( EGateTypes id );
};
#endif
