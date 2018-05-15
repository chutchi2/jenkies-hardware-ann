/*------------------------------------------------------------------------------
 Filename: QubitPlus.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QubitPlus.hpp"
#include <cmath>

QubitPlus::QubitPlus()
{
    double const sineFourtyFive = 1.0 / std::sqrt( 2 );
    m_qubitVector[ 0 ] = Qubit( sineFourtyFive, 0.0 );
    m_qubitVector[ 1 ] = Qubit( sineFourtyFive, 0.0 );
}
