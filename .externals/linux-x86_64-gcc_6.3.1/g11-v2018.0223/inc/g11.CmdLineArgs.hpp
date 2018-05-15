/*------------------------------------------------------------------------------
Filename: g11.CmdLineArgs.hpp

Description:
Provides an interface for parsing command line arguments.

Each command line argument is treated as an argument, option, or value.
Everything not considered an option or its value is treated as an argument.

Options are specified with two leading dashes and are followed by an optional
value:
e.g.: --option value

Options do not have to have a value if followed by another option.
e.g.: --option1 --option2 value

All command line arguments that aren't options or values are added to a list of
arguments that do not include options. If an option is listed more than once,
the last value is assigned to the option.

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_CmdLineArgs_hpp
#define g11_CmdLineArgs_hpp

#include "g11.root.hpp"
#include <map>
#include <vector>
#include <string>

namespace g11 {

class CmdLineArgs
{
public:
    // Constructor/Destructor
    CmdLineArgs();
    CmdLineArgs( int &argc, char const * const * const argv );
    ~CmdLineArgs();

    // Implement CmdLineArgs interface
    void parse( int &argc, char const * const * const argv );
    void reset();

    void setCommand( std::string const &command );
    void addOption( std::string const &option );
    void addOption( std::string const &option, std::string const &value );
    void addArgument( std::string const &arg );

    bool has( std::string const &option ) const;
    bool hasValue( std::string const &option ) const;

    void get( std::string const &option, std::string &value ) const;
    void get( std::string const &option, UINT32 &value ) const;
    void get( std::string const &option, INT32 &value ) const;
    void get( std::string const &option, double &value ) const;

    std::string getString( std::string const &option, std::string const &defVal = "" ) const;
    UINT32      getUINT32( std::string const &option, UINT32      const defVal = 0   ) const;
    INT32       getINT32 ( std::string const &option, INT32       const defVal = 0   ) const;
    double      getDouble( std::string const &option, double      const defVal = 0.0 ) const;

    typedef std::vector< std::string > Arguments;

    UINT32 getOptionCount() const { return m_options.size(); }
    UINT32 getArgumentCount() const { return m_args.size(); }

    std::string const & getCommand() const { return m_command; }
    Arguments const & arguments() const { return m_args; }

private:
    DISALLOW_COPY_AND_ASSIGN( CmdLineArgs );

    // Implement CmdLineArgs private interface
    std::string const & getValue( std::string const &option ) const;

    // Member Variables
    typedef std::map< std::string, std::string > Options;
    Options m_options;

    Arguments m_args;
    std::string m_command;
};

} // End namespace

#endif
