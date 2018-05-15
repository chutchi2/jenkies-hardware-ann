/*------------------------------------------------------------------------------
 Filename: IdentityGate.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef IdentityGate_hpp
#define IdentityGate_hpp

#include "IGate.hpp"

class IdentityGate: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     uint64_t noOfEntangledQubits )
    {
        return inputQubit;
    }
};
#endif
