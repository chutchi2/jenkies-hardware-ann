/*------------------------------------------------------------------------------
 Filename: QRegisterOperations.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef QRegisterOperations_hpp
#define QRegisterOperations_hpp

#include "q3.root.hpp"

class QRegisterOperations
{
private:
    // Member Variables


public:
    //-----------------------------------------------------------------------------
    QRegisterOperations();

    //-----------------------------------------------------------------------------
    ~QRegisterOperations();

    //-----------------------------------------------------------------------------
    Qubit entangle( QRegister quantumRegister );
};
#endif
