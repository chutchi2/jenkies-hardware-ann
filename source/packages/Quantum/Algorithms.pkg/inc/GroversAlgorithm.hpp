/*------------------------------------------------------------------------------
 Filename: GroversAlgorithm.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef GroversAlgorithm_hpp
#define GroversAlgorithm_hpp

#include "QuantumAlgorithms.hpp"

class GroversAlgorithm: public QuantumAlgorithms
{
public:
    //-----------------------------------------------------------------------------
    GroversAlgorithm();

    //-----------------------------------------------------------------------------
    ~GroversAlgorithm();

    //-----------------------------------------------------------------------------
    void run();

    //-----------------------------------------------------------------------------
    void measure();

private:
    // Member Variables
    static uint8_t const maxNumInput = 3;
    IGate gateH;
    IGate gateX;
    IGate gateCNot;
    IGate gateCPhaseShift;
};

#endif
