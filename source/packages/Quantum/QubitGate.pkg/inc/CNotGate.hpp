/*------------------------------------------------------------------------------
 Filename: CNotGate.hpp

 Description:
 Implements the CNOT Gate
 ------------------------------------------------------------------------------*/
#ifndef CNotGate_hpp
#define CNotGate_hpp

#include "IGate.hpp"

class CNotGate: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     int noOfEntangledQubits );
};
#endif
