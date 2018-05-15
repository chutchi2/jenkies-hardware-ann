/*------------------------------------------------------------------------------
 Filename: QubitZero.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QubitZero.hpp"

QubitZero::QubitZero()
{
    m_qubitVector[ 0 ] = Qubit( 1.0, 0.0 );
    m_qubitVector[ 1 ] = Qubit( 0.0, 0.0 );
}
