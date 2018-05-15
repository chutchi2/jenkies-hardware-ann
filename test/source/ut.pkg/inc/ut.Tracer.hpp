// Classification: UNCLASSIFIED

/*------------------------------------------------------------------------------
 Filename: ut.Tracer.hpp

 Description:
 Keeps track of the number of times each of the six special functions get
 called.

 Used to better understand the new C++11 move semantics and validate correct
 implementations of code under test.

 Copyright (c) 2017 Cosmic AES. All rights reserved.
 -----------------------------------------------------------------------------*/
#ifndef ut_Tracer_hpp
#define ut_Tracer_hpp

#include "ut.root.hpp"
#include <map>

namespace ut {

class Tracer
{
public:
    // Object management
    Tracer();
    virtual ~Tracer();

    Tracer( const Tracer& rhs );
    Tracer( Tracer&& rhs );

    Tracer& operator=( const Tracer& rhs );
    Tracer& operator=( Tracer&& rhs );

    // Implement Tracer interface
    static bool isPrintEnabled( bool const isPrintEnabled )
    { return m_isGlobalPrintEnabled = isPrintEnabled; }

    enum class SpecialMethod
    {
        CTOR,
        DTOR,
        COPY_CTOR,
        MOVE_CTOR,
        COPY_ASSIGNMENT,
        MOVE_ASSIGNMENT
    };

    UINT32 getCount( SpecialMethod m ) const;

    void reset()
    {
        m_counts.clear();
    }

    virtual void test(){}

private:
    static bool isPrintEnabled() { return m_isGlobalPrintEnabled; }
    static bool m_isGlobalPrintEnabled;

    void print( char const * const pStr );

    void increment( SpecialMethod m )
    {
        ++m_counts[ m ];
    }

    std::map< SpecialMethod, UINT32 > m_counts;

}; // End class Tracer

} // End namespace

#endif

// Classification: UNCLASSIFIED
