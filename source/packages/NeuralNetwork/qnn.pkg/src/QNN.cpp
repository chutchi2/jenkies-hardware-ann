/*------------------------------------------------------------------------------
 Filename: NeuralNetwork.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QNN.hpp"

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void QNN::generateDiffusionMatrix( QubitPlus qubit )
{
    vector<vector<double>> diffusionMatrix = QuantumOperations.outerProduct( qubit, qubit );
    diffusionMatrix = MatrixOperations.multiplyByConstant( diffusionMatrix, 2 );
    vector<vector<double>> identityMatrix = MatrixOperations.generateIdentityMatrix(8);
    diffusionMatrix = MatrixOperations.subtract( diffusionMatrix, identityMatrix );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void QNN::init()
{
    //create gate object
    gateH = gateFactory.getGate(EGateTypes.E_HadamardGate);

    //initialize resultQubit with QubitZero()
    resultQubit = QUBIT_0;

    //create |+> object
    qubitPlus = new QubitPlus();

    //entangle the resultQubit, qubitPlus
    for ( uint64_t iter = 0; iter < NO_OF_INPUT - 1; ++iter )
    {
        resultQubit = QuantumOperations.entangle( resultQubit, QUBIT_0 );
    }

    for ( uint64_t iter = 0; iter < NO_OF_INPUT - 1; ++iter )
    {
        qubitPlus = QuantumOperations.entangle( qubitPlus, new QubitPlus() );
    }

    gateHn = gateH.getUnitaryMatrix();
    for ( uint64_t iter = 0; iter < NO_OF_INPUT - 1; ++iter )
    {
        gateHn = MatrixOperations.tensorProduct( gateHn, gateH.getUnitaryMatrix() );
    }

    //set the oracle
    setOracle( oracleMatrix );

    //generate diffusion matrix
    generateDiffusionMatrix();
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void QNN::run()
{
    //calculate the needed number of iterations
    uint64_t noOfIterations = ( uint64_t )Math.sqrt( Math.pow( 2, NO_OF_INPUT ) );

    //apply Hadamard gate
    resultQubit = QuantumOperations.applyGate( resultQubit, gateHn );

    //perform the Grover iterations
    for (uint64_t iter = 0; iter < noOfIterations + 1; ++iter) {
        resultQubit = QuantumOperations.applyGate( resultQubit, oracleMatrix );
        resultQubit = QuantumOperations.applyGate( resultQubit, diffusionMatrix );
    }
    //test if resulted qubit is valid
    POSTCONDITION( resultQubit.isValid() == true );
}
/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void QNN::GroversAlgorithm()
{
    GroversAlgorithm ga = null;
    ga = new GroversAlgorithm();
    ga.init();
    ga.run();
    ga.measure();
}
/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void QNN::measure()
{
    MeasurementPerformer measurementPerformer = new MeasurementPerformer().configure(resultQubit);
    resultQubit = measurementPerformer.measure();
}