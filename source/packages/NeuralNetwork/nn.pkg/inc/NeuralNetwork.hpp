/*------------------------------------------------------------------------------
 Filename: NeuralNetwork.hpp

 Description:
 None
 -----------------------------------------------------------------------------*/
#ifndef NeuralNetwork_hpp
#define NeuralNetwork_hpp

#include <cstdint>
#include <cmath>
#include <utility>
#include <vector>


class NeuralNetwork
{
    public:
    //-----------------------------------------------------------------------------
    NeuralNetwork( double const trainSetSize, double const n,
                          float const epsilon, double const epoch );

    //-----------------------------------------------------------------------------
    ~NeuralNetwork();

    //-----------------------------------------------------------------------------
    void trainOverEpochs();

    // Member Variable
    double m_trainingSetSize;
    double m_numLayers;
    float m_epsilon;
    double m_epoch;

    std::vector <double> m_inputLayer {0,1};
    std::vector <double> m_weightLayer {0,1};
    std::vector <double> m_outputLayer {0,1};
    std::vector<std::pair<double, double>> m_trainingSet {{0,1},{0,1}};

    private:

    // ---------------------------------RULES--------------------------------------
    //-----------------------------------------------------------------------------
    double sigmoid( double const xIn );

    //-----------------------------------------------------------------------------
    float sigInput( double const cIn, double const wIn, double const xIn );

    //-----------------------------------------------------------------------------
    float inverseSigInput( double const cIn, double const wIn, double const xIn );

    //-----------------------------------------------------------------------------
    double f_theta( double const xIn, double const cIn, double const wIn,
                    double const vIn  );

    //-----------------------------------------------------------------------------
    float errorValue( double const xIn, double const yIn, double const cIn,
                      double const wIn, double const vIn );

    // --------------------------------TRAINING------------------------------------
    //-----------------------------------------------------------------------------
    double weightRunner( double const xIn, double const yIn, double const cIn,
                    double const wIn, double const vIn );
    //-----------------------------------------------------------------------------
    double outputRunner( double const xIn, double const yIn, double const cIn,
                    double const wIn, double const vIn );

    //-----------------------------------------------------------------------------
    double inputRunner( double const xIn, double const yIn, double const cIn,
                    double const wIn, double const vIn );
    //-----------------------------------------------------------------------------
    void train( double const xIn, double const yIn );

    //-----------------------------------------------------------------------------
    void QNNPlotter( double const xIn );

};

#endif