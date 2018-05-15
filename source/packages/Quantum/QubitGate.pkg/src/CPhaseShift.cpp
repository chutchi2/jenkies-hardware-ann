/*------------------------------------------------------------------------------
 Filename: CPhaseShift.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "CPhaseShift.hpp"
#include "ComplexMath.hpp"
Qubit CPhaseShift::applyGate( Qubit inputQubit,
                              std::vector< int > targetPosition,
                              std::vector< int > conditions,
                              int noOfEntangledQubits )
{
    int mask = 0;
    int new_position = 0;

    std::vector <ComplexNumber> states = inputQubit.getQubit();
    for (int i = 0; i < conditions; ++i )
    {
        mask |= ( 1 << ( noOfEntangledQubits - 1 - i ) );
    }
    mask |= ( 1 << ( noOfEntangledQubits - targetPosition[ 0 ] - 1 ) );
    new_position = mask | 0x01;
    states[ mask ] = ComplexMath::multiply( states[ mask ],
                                           ComplexNumber( -1.0, 0.0 ) );

    states[ new_position ] = ComplexMath::multiply( states[ new_position ],
                                                    ComplexNumber( -1.0, 0.0 ) );

    return Qubit( states );
}
