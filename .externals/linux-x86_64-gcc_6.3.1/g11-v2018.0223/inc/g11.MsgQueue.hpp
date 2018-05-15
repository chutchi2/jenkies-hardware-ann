/*------------------------------------------------------------------------------
Filename: g11.MsgQueue.hpp

Description:
Thread safe queue for communicating between threads.

Notes:
* Objects will be copied by value onto and off of the queue.
* The queue is FIFO ordered.
* Adding an item to the queue never blocks.
* The order of multiple consumer threads simultaneously blocked on get() is
  undefined.

Template Parameters:
T - type of object stored on the queue

Copyright (c) 2017 discoversoft.org. All rights reserved.
------------------------------------------------------------------------------*/
#ifndef g11_MsgQueue_hpp
#define g11_MsgQueue_hpp

#include "g11.root.hpp"
#include "g11.AutoLock.hpp"
#include "g11.CountingSema.hpp"
#include "g11.NonRecursiveMutex.hpp"
#include <list>

namespace g11 {

template< class T >
class MsgQueue
{
public:
    // Constructors/Destructors
    MsgQueue();
    ~MsgQueue();

    // Implement MsgQueue interface
    inline RetVal addItem( T item );
    RetVal addItem( T * const pItem );

    RetVal tryGetItem( T * const pItem );
    RetVal getItem( T * const pItem );

    UINT32 size() const;
    bool empty() const;

private:
    DISALLOW_COPY_AND_ASSIGN( MsgQueue );

    RetVal getItemFromQueue( T * const pItem );

    typedef std::list< T > QueueType;
    QueueType m_queue;

    CountingSema m_sema;
    NonRecursiveMutex mutable m_mutex;

}; // End class MsgQueue

/*------------------------------------------------------------------------------
Constructor

Parameters:
None
------------------------------------------------------------------------------*/
template< class T >
MsgQueue< T >::MsgQueue():
m_queue(),
m_sema(),
m_mutex()
{
}

/*------------------------------------------------------------------------------
Destructor

Parameters:
None
------------------------------------------------------------------------------*/
template< class T >
MsgQueue< T >::~MsgQueue()
{
}

/*------------------------------------------------------------------------------
Add an item to the queue.

Parameters:
item - the item to be added to the queue

Return Value:
RV_OK    - if successful
RV_ERROR - if there was an error
------------------------------------------------------------------------------*/
// inline
template< class T >
RetVal MsgQueue< T >::addItem( T item )
{
    return addItem( &item );
}

/*------------------------------------------------------------------------------
Add an item to the queue.

Parameters:
pItem - item to be added to the queue

Return Value:
RV_OK    - if successful
RV_ERROR - if there was an error
------------------------------------------------------------------------------*/
template< class T >
RetVal MsgQueue< T >::addItem( T * const pItem )
{
    // *** Begin Critical Section
    {
        AutoLock lock( m_mutex );
        m_queue.push_back( *pItem );
    }

    return m_sema.signal();
}

/*------------------------------------------------------------------------------
Get an item from the queue.

If the queue is empty, return immediately.

Parameters:
pItem - the item on the queue will be copied into pItem

Return Value:
RV_OK    - if successful
RV_FAIL  - if the queue was empty
RV_ERROR - if there was an error
------------------------------------------------------------------------------*/
template< class T >
RetVal MsgQueue< T >::tryGetItem( T * const pItem )
{
    // Determine if something is on the queue
    RetVal retVal = m_sema.request();
    FATAL( retVal == RV_ERROR );
    if( retVal != RV_OK ) return retVal;

    // Return next item on the queue
    return getItemFromQueue( pItem );
}

/*------------------------------------------------------------------------------
Get an item from the queue.

If the queue is empty, block until an item is available on the queue.

Parameters:
pItem - the item on the queue will be copied into pItem

Return Value:
RV_OK    - if successful
RV_ERROR - if there was an error
------------------------------------------------------------------------------*/
template< class T >
RetVal MsgQueue< T >::getItem( T * const pItem )
{
    // Wait for something on the queue
    RetVal retVal = m_sema.wait();
    FATAL( retVal != RV_OK );

    // Return next item on the queue
    return getItemFromQueue( pItem );
}

/*------------------------------------------------------------------------------
Return the number of items in the queue.

Parameters:
None

Return Value:
The number of items in the queue.
------------------------------------------------------------------------------*/
template< class T >
UINT32 MsgQueue< T >::size() const
{
    AutoLock lock( m_mutex );
    return m_queue.size();
}

/*------------------------------------------------------------------------------
Return whether the queue is empty or not.

Parameters:
None

Return Value:
true  - if the queue is empty
false - if the queue is not empty
------------------------------------------------------------------------------*/
template< class T >
bool MsgQueue< T >::empty() const
{
    AutoLock lock( m_mutex );
    return m_queue.empty();
}

/*------------------------------------------------------------------------------
Get an item from the queue.

Parameters:
pItem - the item on the queue will be copied into pItem

Return Value:
RV_OK    - if successful
RV_ERROR - if there was an error
------------------------------------------------------------------------------*/
template< class T >
RetVal MsgQueue< T >::getItemFromQueue( T * const pItem )
{
    AutoLock lock( m_mutex );

    FATAL( m_queue.empty() );

    // Pop the next item off the queue
    *pItem = m_queue.front();
    m_queue.pop_front();

    return RV_OK;
}

} // End namespace

#endif
