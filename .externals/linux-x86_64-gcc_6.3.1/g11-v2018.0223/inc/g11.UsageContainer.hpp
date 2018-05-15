/*------------------------------------------------------------------------------
Filename: g11.UsageContainer.hpp

Description:
Container for Usage objects.

Usages will be deleted when the container is destructed.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_UsageContainer_hpp
#define g11_UsageContainer_hpp

#include "g11.root.hpp"
#include <map>
#include <string>

namespace g11 {

class Usage;

class UsageContainer
{
public:
    // Constructors/Destructors
    UsageContainer();
    virtual ~UsageContainer();

    // Implement UsageContainer interface
    RetVal addUsage( std::string const &id, Usage * const pUsage );
    Usage* getUsage( std::string const &id ) const;

private:
    DISALLOW_COPY_AND_ASSIGN( UsageContainer );

    typedef std::map< std::string, Usage* > UsageMap;
    UsageMap m_usages;

}; // End class UsageContainer

} // End namespace

#endif
