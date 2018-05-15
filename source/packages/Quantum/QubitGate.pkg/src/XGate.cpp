/*------------------------------------------------------------------------------
 Filename: XGate.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "XGate.hpp"

Qubit XGate::applyGate( Qubit inputQubit,
                        std::vector< int > targetPosition,
                        std::vector< int > conditions,
                        int noOfEntangledQubits )
{
    int mask = 0;
    int newPosition = 0;
    std::vector< int > states = inputQubit.getQubit();
    std::vector< int > bufferState;
    std::vector< int > markedStates = states.size();
    for( int i = 0; i < targetPosition; ++i )
    {
        //initialize markedstates to all zeroes
        mask = ( 1 << ( noOfEntangledQubits - 1 - i ) );
        for( int j = 0; j < states.size(); ++j )
        {
            if( markedStates[ j ] == 0 )
            {
                bufferState = states[ j ];
                newPosition = j ^ mask;
                states[ j ] = states[ newPosition ];
                states[ newPosition ] = bufferState;
                markedStates[ j ] = 1;
                markedStates[ newPosition ] = 1;
            }
            continue;
        }
        mask = 0;
    }
    return Qubit( states );
}
