/*------------------------------------------------------------------------------
 Filename: IdentityGate.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "IdentityGate.hpp"

Qubit IdentityGate::applyGate( Qubit inputQubit,
                               std::vector< int > targetPosition,
                               std::vector< int > conditions,
                               uint64_t noOfEntangledQubits )
{
    return inputQubit;
}
