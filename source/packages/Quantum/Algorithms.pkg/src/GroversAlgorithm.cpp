/*------------------------------------------------------------------------------
 Filename: QNN.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "GroversAlgorithm.hpp"
#include "GateTypes.hpp"
#include "GateFactory.hpp"
#include "MeasurementPerformer.hpp"
#include "QRegister.hpp"

#include "HGate.hpp"
#include "XGate.hpp"
#include "CNotGate.hpp"
#include "CPhaseShift.hpp"
#include "IdentityGate.hpp"
#include "YGate.hpp"
#include "ZGate.hpp"

#include "QRegisterOperations.hpp"
#include "QuantumOperations.hpp"

#include <vector>


/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
GroversAlgorithm::GroversAlgorithm()
{
    gateH = gateFactory.getGate( E_HadamardGate );
    gateX = gateFactory.getGate( E_XGate );
    gateCNot = gateFactory.getGate( E_CNotGate );
    gateCPhaseShift = gateFactory.getGate( E_CPhaseShift );
    QRegister qRegister = QRegister( ++maxNumInput );
    QRegisterOperations qRegOps = new QRegisterOperations;
    //qRegister = qRegOps.fillWithPattern( "0001" );
    QuantumOperations quantOp = new QuantumOperations();
    Qubit resultQubit = quantOp.entangle( qRegister );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
GroversAlgorithm::~GroversAlgorithm()
{
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void GroversAlgorithm::run()
{
    m_resultQubit = gateH.applyGate( m_resultQubit, std::vector< int >
    { 0, 1, 2, 3 },
                                     {}, maxNumInput + 1 );
    m_resultQubit = gateCNot.applyGate( m_resultQubit, std::vector< int >
    { 3 },
                                        std::vector< int >
                                        { 0, 1, 2 },
                                        maxNumInput + 1 );

    m_resultQubit = gateH.applyGate( m_resultQubit, std::vector< int >
    { 0, 1, 2 },
                                     {}, ++maxNumInput );
    m_resultQubit = gateX.applyGate( m_resultQubit, std::vector< int >
    { 0, 1, 2 },
                                     {}, maxNumInput + 1 );
    m_resultQubit = gateCPhaseShift.applyGate( m_resultQubit, std::vector< int >
    { 2 },
                                               std::vector< int >
                                               { 0, 1 },
                                               maxNumInput + 1 );

    m_resultQubit = gateX.applyGate( m_resultQubit, std::vector< int >
    { 0, 1, 2 },
                                     {}, maxNumInput + 1 );
    m_resultQubit = gateH.applyGate( m_resultQubit, std::vector< int >
    { 0, 1, 2, 3 },
                                     {}, maxNumInput + 1 );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void GroversAlgorithm::measure()
{
    MeasurementPerformer measurementPerformer = new MeasurementPerformer();
    measurementPerformer.configure( m_resultQubit );
    m_resultQubit = measurementPerformer.measure();
    std::cout << ( m_resultQubit ) << std::endl;
}

