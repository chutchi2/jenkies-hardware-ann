/*------------------------------------------------------------------------------
 Filename: QuantumOperations.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef QuantumOperations_hpp
#define QuantumOperations_hpp

#include "q3.root.hpp"

class QuantumOperations
{
private:
    // Member Variables

public:
    //-----------------------------------------------------------------------------
    QuantumOperations();

    //-----------------------------------------------------------------------------
    ~QuantumOperations();

    //-----------------------------------------------------------------------------
    static Qubit QuantumOperations::entangle( Qubit q1, Qubit q2 );

    //-----------------------------------------------------------------------------
    static Qubit QuantumOperations::entangle( QRegister qRegister );

    //-----------------------------------------------------------------------------
    static Qubit QuantumOperations::performTensorProduct( Qubit q1, Qubit q2 );

    //-----------------------------------------------------------------------------
    static std::vector< std::vector< ComplexNumber > > QuantumOperations::calculateTranspose( std::vector<
                    ComplexNumber > z );

    //-----------------------------------------------------------------------------
    static std::vector< std::vector< ComplexNumber > > QuantumOperations::transpose( Qubit q );

    //-----------------------------------------------------------------------------
    static std::vector< std::vector< ComplexNumber > > QuantumOperations::transpose( std::vector<
                    ComplexNumber > z );

    //-----------------------------------------------------------------------------
    static std::vector< std::vector< ComplexNumber > > QuantumOperations::calculateOuterProduct( std::vector<
                                                                                                                 ComplexNumber > z1,
                                                                                                 std::vector<
                                                                                                                 ComplexNumber > z2 );
    //-----------------------------------------------------------------------------
    static std::vector< std::vector< ComplexNumber > > QuantumOperations::outerProduct( Qubit q1,
                                                                                        Qubit q2 );
    //-----------------------------------------------------------------------------
    static std::vector< std::vector< ComplexNumber > > QuantumOperations::outerProduct( std::vector<
                                                                                                        ComplexNumber > z1,
                                                                                        std::vector<
                                                                                                        ComplexNumber > z2 );
    //-----------------------------------------------------------------------------
    static ComplexNumber QuantumOperations::calculateInnerProduct(std::vector< ComplexNumber > z1, std::vector< ComplexNumber > z2);

    //-----------------------------------------------------------------------------
    static ComplexNumber QuantumOperations::innerProduct( Qubit q1, Qubit q2 );

    //-----------------------------------------------------------------------------
    static ComplexNumber QuantumOperations::innerProduct( std::vector< ComplexNumber > z1,
                                                          std::vector< ComplexNumber > z2 );
};
#endif
