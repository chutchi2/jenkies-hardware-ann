/*------------------------------------------------------------------------------
 Filename: HGate.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef HGate_hpp
#define HGate_hpp

#include "IGate.hpp"

class HGate: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< uint64_t > targetPosition,
                     std::vector< uint64_t > conditions,
                     uint64_t noOfEntangledQubits );
};
#endif
