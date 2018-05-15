/*------------------------------------------------------------------------------
 Filename: MeasurementPerformer.hpp

 Description:
 Program entry point.
 ------------------------------------------------------------------------------*/
#ifndef MeasurementPerformer_hpp
#define MeasurementPerformer_hpp

#include "QuantumAlgorithms.hpp"

static double const Q_TOLERANCE = 0.1e-5;

class MeasurementPerformer
{
public:
    //-----------------------------------------------------------------------------
    MeasurementPerformer();

    //-----------------------------------------------------------------------------
    ~MeasurementPerformer();

    //-----------------------------------------------------------------------------
    void configure( Qubit m_resultQubit );

    //-----------------------------------------------------------------------------
    Qubit measure();

    //-----------------------------------------------------------------------------
    void collapseState( uint64_t const position );

    //-----------------------------------------------------------------------------
    uint64_t fakeMeasure();
private:
    // Member Variables
    Qubit m_resultQubit = NULL;
    uint64_t m_length;
};
#endif
