/*------------------------------------------------------------------------------
 Filename: XGate.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
// Implement the Pauli-X Gate.
#ifndef XGate_hpp
#define XGate_hpp

#include "IGate.hpp"

class XGate: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     int noOfEntangledQubits );
};
#endif
