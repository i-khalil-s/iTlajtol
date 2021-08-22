# iTlajtol

![iTlajtol](https://github.com/i-khalil-s/iTlajtol/blob/main/icns.png?raw=true)

iTlajtol is a mobile application that can translate from Nahuatl to Spanish and vice-versa.

## Requerimients

This work is based on [FastAI](https://github.com/fastai/) and uses [SentencePiece](https://github.com/google/sentencepiece). To prepare an enviroment to run this models, please install the [requirements](requirements.txt).

## Corpus

There are 2 main corpuses, first is [Axolotl](corpuses/Axolotl.csv) from [this web](https://axolotl-corpus.mx/about). And the [second one](corpuses/JW100.csv) is a webscrapping result from [JW](https://jw.org) using Nahuatl de la Huasteca.

## Neural networks

This work also uses two NN architectures, an [RNN](NN/RNN-Attention-Translation.ipynb) that implements attention and a [Transformer](NN/Transformer-Translation.ipynb). This implementations are from [FastAI](https://github.com/fastai/course-nlp) and were finetunned to accomodate a low-resource language such as Nahuatl.

## Models

There are several models to carry out a comparative analysis. Such models can be found on the [models](models/) folder with a `pkl` extension and its weights as a `pth` file.

## Data

## Vocab

## iOS Client

There are two clients, one written in Objective-C and the other in Swift using SwiftUI.

### Cite this work

[IEEEXplore](https://ieeexplore.ieee.org/document/9307780)

    @INPROCEEDINGS{9307780,
        author={Bello García, Sergio Khalil and Sánchez Lucero, Eduardo and Pedroza Méndez, Blanca Estela and Hernández Hernández, José Crispín and Bonilla Huerta, Edmundo and Ramírez Cruz, José Federico},  
        booktitle={2020 8th International Conference in Software Engineering Research and Innovation (CONISOFT)},   
        title={Towards the implementation of an Attention-based Neural Machine Translation with artificial pronunciation for Nahuatl as a mobile application},   
        year={2020}, 
        pages={235-244},  
        doi={10.1109/CONISOFT50191.2020.00041}
    }
