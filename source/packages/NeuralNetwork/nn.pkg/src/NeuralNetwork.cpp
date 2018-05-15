/*------------------------------------------------------------------------------
 Filename: NeuralNetwork.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "NeuralNetwork.hpp"
#include "q3.root.hpp"
#include <iostream>

//-----------------------------------------------------------------------------
NeuralNetwork::NeuralNetwork( double const trainSetSize,
double const numLayers, float const epsilon, double const epoch ):
m_trainingSetSize( trainSetSize ),
m_numLayers( numLayers ),
m_epsilon( epsilon ),
m_epoch( epoch )
{
    m_trainingSet.resize( m_trainingSetSize );
    m_inputLayer.resize( m_numLayers );
    m_outputLayer.resize( m_numLayers );
    m_weightLayer.resize( m_numLayers );
}

//-----------------------------------------------------------------------------
NeuralNetwork::~NeuralNetwork()
{
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
double NeuralNetwork::sigmoid( double const xIn )
{
    return ( 1.0f / ( 1.0f + std::exp( -xIn ) ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
float NeuralNetwork::perceptron( double const cIn, double const wIn,
                                      double const xIn )
{
    return sigmoid( cIn + wIn * xIn );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
float NeuralNetwork::inversePerceptron( double const cIn,
                                             double const wIn,
                                             double const xIn )
{
    return ( 1 - perceptron( cIn, wIn, xIn ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
double NeuralNetwork::f_theta( double const xIn, double const cIn,
                                      double const wIn, double const vIn  )
{
    static double result = 0;
    for ( uint64_t iter = 0; iter < m_numLayers; ++iter )
        result += vIn * perceptron( cIn, wIn, xIn );
    return result;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
float NeuralNetwork::errorValue( double const xIn, double const yIn,
                                        double const cIn, double const wIn,
                                        double const vIn )
{
    return 2 * m_epsilon * ( f_theta( xIn, cIn, wIn, vIn ) - yIn );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
float NeuralNetwork::forwardPropagation( double const xIn, double const yIn,
                                        double const cIn, double const wIn,
                                        double const vIn )
{
    return errorValue( xIn, yIn, cIn, wIn, vIn )
           * inversePerceptron( cIn, wIn, xIn)
           * perceptron( cIn, wIn, xIn );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
float NeuralNetwork::backPropagation( double const xIn, double const yIn,
                                        double const cIn, double const wIn,
                                        double const vIn )
{
    return  errorValue( xIn, yIn, cIn, wIn, vIn ) * perceptron( cIn, wIn, xIn );
}


/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
double NeuralNetwork::weightRunner( double const xIn, double const yIn,
                                           double const cIn, double const wIn,
                                           double const vIn )
{
    return ( wIn - vIn * xIn * forwardPropagation( xIn, yIn, cIn, wIn, vIn ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
double NeuralNetwork::outputRunner( double const xIn, double const yIn,
                                           double const cIn, double const wIn,
                                           double const vIn )
{
    return ( vIn - backPropagation( xIn, yIn, cIn, wIn, vIn ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
double NeuralNetwork::inputRunner( double const xIn, double const yIn,
                                          double const cIn, double const wIn,
                                          double const vIn )
{
    return ( cIn - vIn * forwardPropagation( xIn, yIn, cIn, wIn, vIn ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void NeuralNetwork::train( double const xIn, double const yIn )
{
    //update_layers
    for( uint64_t iter = 0; iter < m_numLayers; ++iter )
    {
        m_weightLayer[iter] = weightRunner( xIn,
                                            yIn,
                                            m_inputLayer[iter],
                                            m_weightLayer[iter],
                                            m_outputLayer[iter] );
        m_outputLayer[iter] = outputRunner( xIn,
                                            yIn,
                                            m_inputLayer[iter],
                                            m_weightLayer[iter],
                                            m_outputLayer[iter] );
        m_inputLayer[iter] = inputRunner( xIn,
                                          yIn,
                                          m_inputLayer[iter],
                                          m_weightLayer[iter],
                                          m_outputLayer[iter] );
    }
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void NeuralNetwork::trainOverEpochs()
{
    for( uint64_t epochCount = 0; epochCount < m_epoch; ++epochCount ) {
        for( uint64_t exampleCount = 0; exampleCount < m_trainingSetSize; ++exampleCount )
            train( m_trainingSet[exampleCount].first, m_trainingSet[exampleCount].second );
        std::cout << iter << "\r";
    }
}
