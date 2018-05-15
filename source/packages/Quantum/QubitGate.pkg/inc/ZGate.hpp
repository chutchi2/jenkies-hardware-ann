/*------------------------------------------------------------------------------
 Filename: ZGate.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef ZGate_hpp
#define ZGate_hpp

#include "IGate.hpp"

// Implements the Pauli-Z Gate.
class ZGate: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     int noOfEntangledQubits );
};
#endif
