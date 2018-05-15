/*------------------------------------------------------------------------------
 Filename: YGate.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "YGate.hpp"
#include "ComplexMath.hpp"

Qubit YGate::applyGate( Qubit inputQubit,
                        std::vector< int > targetPosition,
                        std::vector< int > conditions,
                        int noOfEntangledQubits )
{
    int mask = 0;
    int newPosition = 0;
    std::vector< int > states = inputQubit.getQubit();
    std::vector< int > bufferState;
    std::vector< int > markedStates = new int[ states.size() ];
    for( int i = 0; i < targetPosition, ++i )
    {
        //Arrays.fill(markedStates, 0);
        mask = ( 1 << ( noOfEntangledQubits - 1 - i ) );
        for ( int j = 0; j < states.length(); ++j )
        {
            if (markedStates[j] == 0)
            {
                newPosition = j ^ mask;
                bufferState = states[j];
                states[j] = ComplexMath.multiply(vector<int>
                                {   0.0,-1.0}, states[newPosition]);
                states[newPosition] = ComplexMath.multiply(vector<int>
                                {   0.0,1.0}, bufferState);
                markedStates[j] = 1;
                markedStates[newPosition] = 1;
            }
            continue;
        }
        mask = 0;
    }
    return Qubit( states );

}
