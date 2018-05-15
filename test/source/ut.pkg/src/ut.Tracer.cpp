/*------------------------------------------------------------------------------
 Filename: ut.Tracer.cpp

 Description:
 Keeps track of the number of times each of the six special functions get
 called.

 Used to better understand the new C++11 move semantics and validate correct
 implementations of code under test.
 -----------------------------------------------------------------------------*/
#include "ut.Tracer.hpp"
#include <iostream>

using namespace ut;

//------------------------------------------------------------------------------
bool Tracer::m_isGlobalPrintEnabled = false;

//------------------------------------------------------------------------------
Tracer::Tracer():
m_counts()
{
    increment( SpecialMethod::CTOR );
    print( "Constructor" );
}

//------------------------------------------------------------------------------
// virtual
Tracer::~Tracer()
{
    increment( SpecialMethod::DTOR );
    print( "Destructor" );
}

//------------------------------------------------------------------------------
Tracer::Tracer( const Tracer& rhs ):
m_counts( rhs.m_counts )
{
    increment( SpecialMethod::COPY_CTOR );
    print( "Copy Constructor" );
}

//------------------------------------------------------------------------------
Tracer::Tracer( Tracer&& rhs ):
m_counts( std::move( rhs.m_counts ) )
{
    increment( SpecialMethod::MOVE_CTOR );
    print( "Move Constructor" );
}

//------------------------------------------------------------------------------
Tracer& Tracer::operator=( const Tracer& rhs )
{
    m_counts = rhs.m_counts;
    increment( SpecialMethod::COPY_ASSIGNMENT );
    print( "Copy Assignment" );
    return *this;
}

//------------------------------------------------------------------------------
Tracer& Tracer::operator=( Tracer&& rhs )
{
    m_counts = std::move( rhs.m_counts );
    increment( SpecialMethod::MOVE_ASSIGNMENT );
    print( "Move Assignment" );
    return *this;
}

//----------------------------------------------------------------------
UINT32 Tracer::getCount( SpecialMethod m ) const
{
    UINT32 count = 0;

    try
    {
        count = m_counts.at( m );
    }
    catch( ... )
    {
        // Special method has not been called
    }

    return count;
}

//----------------------------------------------------------------------
void Tracer::print( char const * const pStr )
{
    if( Tracer::isPrintEnabled() )
    {
        std::cout << pStr << std::endl;
    }
}

