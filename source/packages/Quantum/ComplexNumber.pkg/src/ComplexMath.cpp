/*-----------------------------------------------------------------------------
 Filename: ComplexMath.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "ComplexMath.hpp"
#include <cmath>
/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::add( ComplexNumber z1, ComplexNumber z2 )
{
    return ComplexNumber( z1.getReal() + z2.getReal(),
                          z1.getImaginary() + z2.getImaginary() );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::multiply( ComplexNumber z1, ComplexNumber z2 )
{
    return ComplexNumber( z1.getReal() * z2.getReal()
                                          - z1.getImaginary()
                                                          * z2.getImaginary(),
                          z1.getReal() * z2.getImaginary()
                                          + z1.getImaginary() * z2.getReal() );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::subtract( ComplexNumber z1, ComplexNumber z2 )
{

    return ComplexNumber( z1.getReal() - z2.getReal(),
                          z1.getImaginary() - z2.getImaginary() );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::divide( ComplexNumber z1, ComplexNumber z2 )
{
    ComplexNumber numerator = multiply( z1, conjugate( z2 ) );
    double denominator = std::pow( mod( z2 ), 2 );
    return ComplexNumber( numerator.getReal() / denominator,
                          numerator.getImaginary() / denominator );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::conjugate( ComplexNumber z )
{

    return ComplexNumber( z.getReal(), -z.getImaginary() );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static double ComplexMath::mod( ComplexNumber z )
{

    return std::sqrt( std::pow( z.getReal(), 2 )
                    + std::pow( z.getImaginary(), 2 ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::square( ComplexNumber z )
{
    return ComplexNumber( z.getReal() * z.getReal()
                                          - z.getImaginary() * z.getImaginary(),
                          2 * z.getReal() * z.getImaginary() );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::sin( ComplexNumber z )
{
    double const exp = std::exp( z.getImaginary() );
    return ComplexNumber( std::sin( z.getReal() ) * ( exp + 1 / exp ) / 2.0,
                          std::cos( z.getReal() ) * ( exp - 1 / exp ) / 2.0 );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::cos( ComplexNumber z )
{
    double exp = std::exp( z.getImaginary() );
    return ComplexNumber( std::cos( z.getReal() ) * ( exp + 1 / exp ) / 2.0,
                          -std::sin( z.getReal() ) * ( exp - 1 / exp ) / 2.0 );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::tan( ComplexNumber z )
{
    return divide( sin( z ), cos( z ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::exp( ComplexNumber z )
{
    double r = std::exp( z.getReal() );
    return ComplexNumber( r * std::cos( z.getImaginary() ),
                          r * std::sin( z.getImaginary() ) );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::pow( ComplexNumber z, int power )
{
    double realValue = z.getReal();
    double imaginaryValue = z.getImaginary();
    for( int i = 0; i < power - 1; ++i )
    {
        realValue = realValue * z.getReal() - imaginaryValue * z.getImaginary();
        imaginaryValue = realValue * z.getImaginary()
                        + imaginaryValue * z.getReal();
    }
    return ComplexNumber( realValue, imaginaryValue );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::inverse( ComplexNumber z )
{
    return divide( ComplexNumber( 1, 0 ), z );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::multiply( ComplexNumber z, double constant )
{
    return ComplexNumber( z.getReal() * constant, z.getImaginary() * constant );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::add( ComplexNumber z, double constant )
{
    return ComplexNumber( z.getReal() + constant, z.getImaginary() );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::subtract( ComplexNumber z, double constant )
{

    return ComplexNumber( z.getReal() - constant, z.getImaginary() );
}
/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
static ComplexNumber ComplexMath::divide( ComplexNumber z, double constant )
{
    return ComplexNumber( z.getReal() / constant, z.getImaginary() / constant );
}
