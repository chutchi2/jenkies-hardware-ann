/*------------------------------------------------------------------------------
 Filename: GateFactory.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "GateFactory.hpp"
#include "HGate.hpp"
#include "XGate.hpp"
#include "YGate.hpp"
#include "ZGate.hpp"
#include "CNotGate.hpp"
#include "CPhaseShift.hpp"
#include "IdentityGate.hpp"

IGate GateFactory::getGate( EGateTypes id )
{
    IGate gate = NULL;
    switch( id )
    {
        case E_HadamardGate:
            gate = HGate();
            break;
        case E_XGate:
            gate = XGate();
            break;
        case E_YGate:
            gate = YGate();
            break;
        case E_ZGate:
            gate = ZGate();
            break;
        case E_CNotGate:
            gate = CNotGate();
            break;
        case E_CPhaseShift:
            gate = CPhaseShift();
            break;
        case E_IGate:
            gate = IdentityGate();
            break;
    }
    return gate;
}
