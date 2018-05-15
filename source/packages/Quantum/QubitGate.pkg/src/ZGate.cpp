/*------------------------------------------------------------------------------
 Filename: ZGate.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "ZGate.hpp"

Qubit ZGate::applyGate( Qubit inputQubit,
                        std::vector< int > targetPosition,
                        std::vector< int > conditions,
                        int noOfEntangledQubits )
{
    int mask = 0;
    int newPosition = 0;
    std::vector< int > states = inputQubit.getQubit();
    std::vector< int > markedStates = states.size();
    for (int i = 0; i < targetPosition, ++i )
    {
        Arrays.fill(markedStates, 0);
        mask = (1 << (noOfEntangledQubits - 1 - i));
        for (int j = 0; j < states.length(); ++j)
        {
            if (markedStates[j] == 0)
            {
                newPosition = j ^ mask;
                states[j] = ComplexMath.multiply(states[j],vector<int>
                                {   1.0, 0.0});
                states[newPosition] = ComplexMath.multiply(states[newPosition], vector<int>
                                {   -1.0, 0.0});
                markedStates[j] = 1;
                markedStates[newPosition] = 1;
            }
            continue;
        }
        mask = 0;
    }
    return Qubit( states );
}
