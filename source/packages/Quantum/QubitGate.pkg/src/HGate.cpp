/*------------------------------------------------------------------------------
 Filename: HGate.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "HGate.hpp"
#include "ComplexMath.hpp"
Qubit HGate::applyGate( Qubit inputQubit,
                        std::vector< uint64_t > targetPosition,
                        std::vector< uint64_t > conditions,
                        uint64_t noOfEntangledQubits )
{
    uint64_t mask = 0;
    uint64_t newPosition = 0;
    double hCoefficient = ( 1.0 / std::sqrt(2) );
    std::vector < Qubit > states = inputQubit.getQubit();
    ComplexNumber bufferState;
    std::vector< int > markedStates = states.size();

    for( uint64_t i; i < targetPosition; ++i )
    {
        //fill marked states with zero
        mask = ( 1 << ( noOfEntangledQubits - 1 - i ) );
        for( uint64_t j = 0; j < states.size(); ++j )
        {
            if( markedStates[j] == 0 )
            {
                newPosition = j ^ mask;
                bufferState = states[j];
                states[j] = ComplexMath::multiply(ComplexMath::add(bufferState, states[newPosition].getQubit()), hCoefficient );

                states[newPosition] = ComplexMath::multiply(ComplexMath::subtract(bufferState, states[newPosition].getQubit()), hCoefficient) ;
                markedStates[j] = 1;
                markedStates[newPosition] = 1;
            }
        }
        mask = 0;
    }
    return Qubit( states );
}
