/*------------------------------------------------------------------------------
 Filename: IGate.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef IGate_hpp
#define IGate_hpp

#include "Qubit.hpp"

class IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     int noOfEntangledQubits );
};
#endif
