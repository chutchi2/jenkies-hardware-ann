/*------------------------------------------------------------------------------
 Filename: CNotGate.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "CNotGate.hpp"

Qubit CNotGate::applyGate( Qubit inputQubit,
                           std::vector< int > targetPosition,
                           std::vector< int > conditions,
                           int noOfEntangledQubits )
{

    int mask = 0;
    int newPosition = 0;
    std::vector< double > states = inputQubit.getQubit();
    for( int i = 0; i < conditions.size(); ++i )
        mask |= (1 << (noOfEntangledQubits - 1 - i));
    mask |= ( 1 << ( noOfEntangledQubits - targetPosition[ 0 ] ) );
    newPosition = mask | 0x01;
    std::vector< double > state = states[ mask ];
    states[ mask ] = states[ newPosition ];
    states[ newPosition ] = state;

    return Qubit( states );
}
