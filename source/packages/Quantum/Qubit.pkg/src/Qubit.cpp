/*-----------------------------------------------------------------------------
 Filename: Qubit.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "Qubit.hpp"
#include "ComplexMath.hpp"
#include <vector>
#include <cstring>
#include <functional>
#include <iostream>

Qubit::Qubit( double no0, double no1 )
{
    m_qubitVector.set( no0, no1 );
}

Qubit::Qubit( std::vector< double > const qubitVector )
{
    m_qubitVector.set( qubitVector[ 0 ], qubitVector[ 1 ] );
}

Qubit::~Qubit()
{
}

ComplexNumber Qubit::getQubit()
{
    return m_qubitVector;
}

std::string Qubit::qubitString()
{
    std::string output;
    output += "[ ";
    for( uint64_t iter = 0; iter < m_qubitVector; ++iter )
    {
        output += m_qubitVector[iter];
        output += " ";
    }
    output += "]";
    return output;
}

bool Qubit::equals( Qubit refQubit )
{
    return ( m_qubitVector.getReal() != refQubit.m_qubitVector.getReal()
                    || m_qubitVector.getImaginary()
                                    != refQubit.m_qubitVector.getImaginary() );
}s

//uint64_t Qubit::hashCode()
//{
//    uint64_t hash = 5;
//    hash +=
//        ( ( m_qubitVector != NULL ) ? std::hash<double>{}( m_qubitVector ) : 0 );
//    return hash;
//}

bool Qubit::isValid()
{
    double sum = 0.0;
    for( uint64_t iter = 0; iter < m_qubitVector; ++iter )
    {
        sum += ComplexMath::mod( ComplexNumber( iter, iter ) );
    }
    return sum == 1.0;
}
