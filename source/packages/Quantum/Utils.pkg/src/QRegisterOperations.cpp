/*------------------------------------------------------------------------------
 Filename: QRegisterOperations.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QRegisterOperations.hpp"
#include "ComplexMath.hpp"
#include "QRegister.hpp"
#include "QuantumOperations.hpp"
#include "Qubit.hpp"
#include <vector>

QRegisterOperations::QRegisterOperations()
{
}

QRegisterOperations::~QRegisterOperations()
{
}


Qubit entangle( QRegister quantumRegister )
{
    return QuantumOperations::entangle( quantumRegister );
}

//static QRegisterOperations getInstance()
//{
//    return this;
//}
//
//std::vector< Qubit > fillWith( std::vector< Qubit > list,
//                               std::vector< Qubit > qubitSupplier,
//                               int size )
//{
//    list = (qubitSupplier <= size);
//    //Stream.generate(  ).limit(  ).collect( Collectors.toList() );
//    return list;
//}
//
//QRegister fillWith( QRegister reg, std::vector< Qubit > qubitSupplier )
//{
//    reg.setQubits( Stream.generate( qubitSupplier ).limit( reg.size() ).collect( Collectors.toList() ) );
//    return reg;
//}
//
//QRegister fillWithPattern( std::string pattern )
//{
//    QRegister qreg = new QRegister(pattern.length());
//    for (int i = 0; i < pattern.length(); i++)
//    {
//        if (pattern[i] == '1')
//        {
//            qreg.change( i, QubitOne() );
//        }
//        else
//        {
//            qreg.change( i, new QubitZero() );
//        }
//    }
//    return qreg;
//}


