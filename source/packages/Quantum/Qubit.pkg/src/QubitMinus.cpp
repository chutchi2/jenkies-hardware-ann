/*-----------------------------------------------------------------------------
 Filename: QubitMinus.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QubitMinus.hpp"
#include <cmath>

QubitMinus::QubitMinus()
{
    double const sineOneThirtyFive = 1.0 / sqrt( 2 );
    m_qubitVector[ 0 ] = Qubit( sineOneThirtyFive, 0.0 );
    m_qubitVector[ 1 ] = Qubit( -sineOneThirtyFive, 0.0 );
}
