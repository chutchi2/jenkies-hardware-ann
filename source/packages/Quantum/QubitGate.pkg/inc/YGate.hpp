/*------------------------------------------------------------------------------
 Filename: YGate.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef YGate_hpp
#define YGate_hpp

#include "IGate.hpp"

class YGate: public IGate
{
public:
    Qubit applyGate( Qubit inputQubit,
                     std::vector< int > targetPosition,
                     std::vector< int > conditions,
                     int noOfEntangledQubits );
};
#endif
