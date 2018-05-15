/*------------------------------------------------------------------------------
 Filename: CPhaseShift.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef CPhaseShift_hpp
#define CPhaseShift_hpp

#include "IGate.hpp"

class CPhaseShift: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     int noOfEntangledQubits );
};
#endif
