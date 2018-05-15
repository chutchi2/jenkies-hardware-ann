/*------------------------------------------------------------------------------
 Filename: ComplexMath.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef ComplexMath_hpp
#define ComplexMath_hpp

#include "ComplexNumber.hpp"

class ComplexMath
{
public:
    //-----------------------------------------------------------------------------
    static ComplexNumber add( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber multiply( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber subtract( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber divide( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber conjugate( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber add( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber multiply( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber subtract( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber divide( ComplexNumber z1, ComplexNumber z2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber conjugate( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static double mod( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber square( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber sin( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber cos( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber tan( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber exp( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber pow( ComplexNumber z, int power );

    //-----------------------------------------------------------------------------
    static ComplexNumber inverse( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber multiply( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static ComplexNumber add( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static ComplexNumber subtract( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static ComplexNumber divide( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static double mod( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber square( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber sin( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber cos( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber tan( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber exp( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber pow( ComplexNumber z, int power );

    //-----------------------------------------------------------------------------
    static ComplexNumber inverse( ComplexNumber z );

    //-----------------------------------------------------------------------------
    static ComplexNumber multiply( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static ComplexNumber add( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static ComplexNumber subtract( ComplexNumber z, double constant );

    //-----------------------------------------------------------------------------
    static ComplexNumber divide( ComplexNumber z, double constant );
};

#endif
