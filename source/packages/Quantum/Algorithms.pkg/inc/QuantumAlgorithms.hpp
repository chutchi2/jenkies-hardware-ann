/*------------------------------------------------------------------------------
 Filename: QuantumAlgorithms.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef QuantumAlgorithms_hpp
#define QuantumAlgorithms_hpp

#include "Qubit.hpp"
#include "GatesAbstractFactory.hpp"
#include "GateProducer.hpp"
#include "IGate.hpp"
#include "q3.root.hpp"

class QuantumAlgorithms
{
public:
    //-----------------------------------------------------------------------------
    QuantumAlgorithms();

    //-----------------------------------------------------------------------------
    QuantumAlgorithms( IGate oracle );

    //-----------------------------------------------------------------------------
    ~QuantumAlgorithms();

    //-----------------------------------------------------------------------------
    void setOracle( IGate oracle );

    //-----------------------------------------------------------------------------
    void init();

    //-----------------------------------------------------------------------------
    void run();

    //-----------------------------------------------------------------------------
    void measure();

private:
    // Member Variables
    IGate m_oracle;
    Qubit m_resultQubit;
    GatesAbstractFactory gateFactory = GateProducer::getGateFactory();
};

#endif
