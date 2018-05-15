/*------------------------------------------------------------------------------
 Filename: QuantumOperations.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QuantumOperations.hpp"
#include "ComplexMath.hpp"
#include "Qubit.hpp"
#include "QRegister.hpp"
#include <vector>

QuantumOperations::QuantumOperations()
{
}

QuantumOperations::~QuantumOperations()
{
}

static Qubit QuantumOperations::entangle( Qubit q1, Qubit q2 )
{
    return performTensorProduct( q1, q2 );
}

static Qubit QuantumOperations::entangle( QRegister qRegister )
{
    Qubit bufferQubit = qRegister.get( 0 );
    for( int i = 1; i < qRegister.size(); i++ )
        bufferQubit = performTensorProduct( bufferQubit, qRegister.get( i ) );
    return bufferQubit;
}

static Qubit QuantumOperations::performTensorProduct( Qubit q1, Qubit q2 )
{
    int len1 = q1.getQubit();
    int len2 = q2.getQubit();
    std::vector< ComplexNumber > complexNumberList = new ComplexNumber[ len1
                    * len2 ];
    int k = 0;
    for( int i = 0; i < len1; i++ )
    {
        for( int j = 0; j < len2; j++ )
        {
            complexNumberList[ k++ ] =
                ComplexMath::multiply( q1.getQubit(), q2.getQubit() );
        }
    }

    return Qubit( complexNumberList );
}

static std::vector< std::vector< ComplexNumber > > QuantumOperations::calculateTranspose( std::vector<
                ComplexNumber > z )
{
    std::vector< std::vector< ComplexNumber > > transpose =
        new ComplexNumber[ 1 ][ z.size() ];
    for( uint64_t i = 0; i < z.size(); i++ )
        transpose[ 0 ][ i ] = z[ i ];
    return transpose;
}

static std::vector< std::vector< ComplexNumber > > QuantumOperations::transpose( Qubit q )
{
    std::vector< Qubit > tQubit = { ComplexNumber(0,0), q.getQubit() };
    return calculateTranspose( tQubit );
}

static std::vector< std::vector< ComplexNumber > > QuantumOperations::transpose( std::vector<
                ComplexNumber > z )
{
    return calculateTranspose( z );
}

static std::vector< std::vector< ComplexNumber > > QuantumOperations::calculateOuterProduct( std::vector<
                                                                                                             ComplexNumber > z1,
                                                                                             std::vector<
                                                                                                             ComplexNumber > z2 )
{
    std::vector< std::vector< ComplexNumber > > result = NULL;
    if( z1.size() == z2.size() )
    {
        std::vector< std::vector< ComplexNumber > > transposeSecondArray =
            calculateTranspose( z2 );
        int numberOfRows = z1.size();
        int numberOfRowsSecondMatrix = 1;
        int numberOfCollsSecondMatrix = transposeSecondArray[ 0 ].size();
        result = new ComplexNumber[ numberOfRows ][ numberOfCollsSecondMatrix ];
        ComplexNumber sum = ComplexNumber( 0.0, 0.0 );
        // fill matrix with 0;
        for( int i = 0; i < numberOfRows; i++ )
        {
            for( int j = 0; j < numberOfCollsSecondMatrix; j++ )
            {
                for( int k = 0; k < numberOfRowsSecondMatrix; k++ )
                {
                    sum =
                        ComplexMath::add( sum,
                                          ComplexMath::multiply( z1[ i ],
                                                                 transposeSecondArray[ k ][ j ] ) );
                }
                result[ i ][ j ] = sum;
                sum = ComplexNumber();
            }
        }
    }

    return result;
}

static std::vector< std::vector< ComplexNumber > > QuantumOperations::outerProduct( Qubit q1,
                                                                                    Qubit q2 )
{
    return calculateOuterProduct( q1.getQubit(), q2.getQubit() );
}

static std::vector< std::vector< ComplexNumber > > QuantumOperations::outerProduct( std::vector<
                                                                                                    ComplexNumber > z1,
                                                                                    std::vector<
                                                                                                    ComplexNumber > z2 )
{
    return calculateOuterProduct( z1, z2 );
}

static ComplexNumber QuantumOperations::calculateInnerProduct( std::vector<
                                                                               ComplexNumber > z1,
                                                               std::vector<
                                                                               ComplexNumber > z2 )
{
    ComplexNumber result = new ComplexNumber( 0.0, 0.0 );
    if( z1.size() == z2.size() )
    {
        std::vector< std::vector< ComplexNumber > > transposeFirstArray =
            calculateTranspose( z1 );
        int numberOfRows = z2.size();

        for( int i = 0; i < numberOfRows; i++ )
        {
            result =
                ComplexMath::add( result,
                                  ComplexMath::multiply( transposeFirstArray[ 0 ][ i ],
                                                         z2[ i ] ) );
        }
    }
    return result;
}

static ComplexNumber QuantumOperations::innerProduct( Qubit q1, Qubit q2 )
{
    return calculateInnerProduct( q1.getQubit(), q2.getQubit() );
}

static ComplexNumber QuantumOperations::innerProduct( std::vector< ComplexNumber > z1,
                                                      std::vector< ComplexNumber > z2 )
{
    return calculateInnerProduct( z1, z2 );
}
