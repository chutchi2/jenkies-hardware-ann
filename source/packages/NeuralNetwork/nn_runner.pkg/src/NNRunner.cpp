/*------------------------------------------------------------------------------
 Filename: NNRunner.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "NNRunner.hpp"
#include "q3.root.hpp"
#include <cmath>
#include <ctime>
#include <iostream>

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
NNRunner::NNRunner()
{
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
NNRunner::~NNRunner();
{
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void NNRunner::dataInitializer( NeuralNetwork * const pNetwork )
{
    srand( time( NULL ) );
    for( uint64_t iter = 0; iter < pNetwork->m_numLayers; ++iter )
    {
        pNetwork->m_weightLayer[iter] = 2 * rand() / RAND_MAX - 1;
        pNetwork->m_outputLayer[iter] = 2 * rand() / RAND_MAX - 1;
        pNetwork->m_inputLayer[iter] = 2 * rand() / RAND_MAX - 1;
    }
    trainingSetPairCreator( pNetwork );
}


/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void NNRunner::trainingSetPairCreator( NeuralNetwork * const pNetwork )
{   float const twoPi =  2 * 3.141592653589793238463;
    for( uint64_t iter = 0; iter < pNetwork->m_trainingSetSize; ++iter )
    {
        float real = iter * twoPi / pNetwork->m_trainingSetSize;
        float imag = sin( real );
        pNetwork->m_trainingSet[iter] = std::make_pair( real, imag );
    }
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
-----------------------------------------------------------------------------*/
void NeuralNetwork::QNNPlotter( double const xIn )
{
    FILE * const pGnuPlot = popen( "gnuplot", "w" );
    fprintf( pGnuPlot, "set terminal wxt size 600,400 \n" );
    fprintf( pGnuPlot, "set grid \n" );
    fprintf( pGnuPlot, "set title '%s' \n", "f(x) = sin (x)" );
    fprintf( pGnuPlot, "set style line 1 lt 3 pt 7 ps 0.1 lc rgb 'green' lw 1 \n" );
    fprintf( pGnuPlot, "set style line 2 lt 3 pt 7 ps 0.1 lc rgb 'red' lw 1 \n" );
    fprintf( pGnuPlot, "plot '-' w p ls 1, '-' w p ls 2 \n" );

    fprintf( pGnuPlot, "%f %f \n", xIn, sin( xIn ) );
    fprintf( pGnuPlot, "e\n" );

    // fprintf( pGnuPlot, "%f %f \n", xIn, f_theta( xIn ) );
    // fprintf( pGnuPlot, "e\n" );
    fflush( pGnuPlot );
    //int64_t const rc = system("pause");

    pclose( pGnuPlot );
}