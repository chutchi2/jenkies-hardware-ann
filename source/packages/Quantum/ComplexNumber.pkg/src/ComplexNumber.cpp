/*-----------------------------------------------------------------------------
 Filename: ComplexNumber.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "ComplexNumber.hpp"
#include <cstdio>

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
ComplexNumber::ComplexNumber( double real, double imaginary ) :
                m_imaginary( imaginary ),
                m_real( real )
{
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
ComplexNumber::ComplexNumber() :
                m_imaginary( 0.0 ),
                m_real( 0.0 )
{
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void ComplexNumber::set( double real, double imaginary )
{
    m_real = real;
    m_imaginary = imaginary;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void ComplexNumber::setReal( double real )
{
    m_real = real;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
double ComplexNumber::getReal()
{
    return m_real;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void ComplexNumber::setImaginary( double imaginary )
{
    m_imaginary = imaginary;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
double ComplexNumber::getImaginary()
{
    return m_imaginary;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
bool ComplexNumber::equals( ComplexNumber cNum )
{
    return ( cNum.getReal() == m_real ) && ( cNum.getImaginary() == m_imaginary );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
std::string ComplexNumber::toString()
{
    return ( ( m_imaginary < 0 ) ?
        ( std::printf( "%f%fi", m_real, m_imaginary ) ) :
        ( std::printf( "%f+%fi", m_real, m_imaginary ) ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
double ComplexNumber::getArg()
{
    return std::atan2( m_imaginary, m_real );
}
