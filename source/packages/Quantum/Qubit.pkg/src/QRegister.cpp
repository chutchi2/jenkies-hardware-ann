/*-----------------------------------------------------------------------------
 Filename: QRegister.cpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#include "QRegister.hpp"

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
QRegister::QRegister( uint64_t const size ) :
                m_registerSize( size )
{
    m_qubitRegister.resize( size );
    qubitRegister = QRegisterOperations.getInstance().fillWith(qubitRegister, QubitZero::new, registerSize);
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
uint64_t QRegister::size()
{
return m_registerSize;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void QRegister::add( Qubit newQubit )
{
PRECONDITION( qubitRegister.size() >= registerSize )
m_qubitRegister.push_back( newQubit );
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void QRegister::change( uint64_t index, Qubit e )
{
    m_qubitRegister[ index ] = e;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
Qubit QRegister::get( uint64_t index )
{
    return m_qubitRegister[ index ];
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
//Iterator< Qubit > QRegister::iterator()
//{
//    return m_qubitRegister.iterator();
//}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
std::vector< Qubit > QRegister::getQubits()
{
    return m_qubitRegister;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
void QRegister::setQubits( std::vector< Qubit > qubits )
{
    m_qubitRegister = qubits;
}

/*-----------------------------------------------------------------------------
 None

 Parameters:
 None

 Return Value:
 None
 -----------------------------------------------------------------------------*/
std::string QRegister::qubitRegisterString()
{
    std::string output;
    output.append( "[ " );
    for( uint64_t iter = 0; iter < m_qubitRegister.length(), ++iter )
    {
        output.append(m_qubitRegister[iter]);
        output.append(" ");
    }
    output.append( "]" );
    return output;
}
