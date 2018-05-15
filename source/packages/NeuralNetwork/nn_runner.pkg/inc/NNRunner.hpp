/*------------------------------------------------------------------------------
 Filename: NNRunner.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef NNRunner_hpp
#define NNRunner_hpp

class NNRunner
{
    public:
    //-----------------------------------------------------------------------------
    NNRunner();

    //-----------------------------------------------------------------------------
    ~NNRunner();

    //-----------------------------------------------------------------------------
    void dataInitializer( NeuralNetwork * const pNetwork );

    //-----------------------------------------------------------------------------
    void QNNPlotter( double const xIn );

    private:
    void trainingSetPairCreator( NeuralNetwork * const pNetwork );
};

#endif