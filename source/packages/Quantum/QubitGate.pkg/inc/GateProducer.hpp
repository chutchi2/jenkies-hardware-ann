/*------------------------------------------------------------------------------
 Filename: GateProducer.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef GateProducer_hpp
#define GateProducer_hpp

#include "GateFactory.hpp"

class GateProducer: public GatesAbstractFactory
{
public:
    static GateFactory getGateFactory();
};
#endif
