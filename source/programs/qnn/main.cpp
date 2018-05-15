/*------------------------------------------------------------------------------
Filename: main.cpp

Description:
Program entry point.
------------------------------------------------------------------------------*/
#include "q3.root.hpp"
#include "NeuralNetwork.hpp"
#include "NNRunner.hpp"
#include "QNN.hpp"
#include <iostream>
#include <cstdlib>

using namespace q3;

//------------------------------------------------------------------------------
int main( int argc, char **argv )
{
    USED( argv );
    NeuralNetwork * const pNetwork = new NeuralNetwork( 20, 5, 0.05, 50000 );
    //dataInitializer( pNetwork );
    pNetwork->trainOverEpochs();
    
    // Execute usage
    return ( argc == 1 ) ? EXIT_SUCCESS : EXIT_FAILURE;
}
