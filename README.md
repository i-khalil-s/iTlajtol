# iTlajtol

<p align="center">
  <img src="https://github.com/i-khalil-s/iTlajtol/blob/main/icns.png?raw=true"/>
</p>

iTlajtol is a mobile application that can translate from Nahuatl to Spanish and vice-versa.

## Requerimients

This work is based on [FastAI](https://github.com/fastai/) and uses [SentencePiece](https://github.com/google/sentencepiece). To prepare an enviroment to run this models, please install the [requirements](requirements.txt).

## Corpus

There are 2 main corpuses, first is [Axolotl](corpuses/Axolotl.csv) from [this web](https://axolotl-corpus.mx/about). And the [second one](corpuses/JW100.csv) is a webscrapping result from [JW](https://jw.org) using Nahuatl de la Huasteca.

## Neural networks

This work also uses two NN architectures, an [RNN](NN/RNN-Attention-Translation.ipynb) that implements attention and a [Transformer](NN/Transformer-Translation.ipynb). This implementations are from [FastAI](https://github.com/fastai/course-nlp) and were finetunned to accomodate a low-resource language such as Nahuatl.

## Models

There are several models to carry out a comparative analysis. Such models can be found on the [models](models/) folder with a `pkl` extension and its weights as a `pth` file.
So far only the best [Transformer](models/Transformers/JW/Sentence/nch/0.625145/) is available and the first [RNN with attention](models/RNN/Axolotl/Spacy/spa/0.322177/).

| Arquitecture  | Corpus    | Tokenization  | From  | To    | %BLEU|
|----------------|------------|----------------|---------|------|---------|
|Transformer   | JW          | SentencePiece|NCH  |SPA  | 62.5145|
|RNN+Att        | Axolotl    | Spacy            |SPA     |NAH | 32.2177|

## Data

[Transformer](models/Transformers/JW/Sentence/nch/0.625145/JW_Sentence_data.pkl) and [RNN](models/RNN/Axolotl/Spacy/spa/0.322177/Axolotl_Spaicy_es_data.pkl)
This data contains the vocabulary and segmented pieces.

## Vocab

For sentencePiece the vocabulary can be loadded with the files at [vocab](models/Transformers/JW/Sentence/nch/0.625145/vocab/tmp/), such files had to be load with SentencePiece. 

## iOS Client

There are two clients, one written in Objective-C and the other in Swift using SwiftUI.

<p align="center">
  <img src="https://github.com/i-khalil-s/iTlajtol/blob/main/iOS/app.png?raw=true" width="300"/>
</p>

### Cite this work

[IEEEXplore](https://ieeexplore.ieee.org/document/9307780)

    @inproceedings{9307780,
        Author = {S. K. {Bello García} and E. {S{\'a}nchez Lucero} and B. E. {Pedroza M{\'e}ndez} and J. C. {Hern{\'a}ndez Hern{\'a}ndez} and E. {Bonilla Huerta} and J. F. {Ramírez Cruz}},
        Booktitle = {2020 8th International Conference in Software Engineering Research and Innovation (CONISOFT)},
        Doi = {10.1109/CONISOFT50191.2020.00041},
        Keywords = {Spectrogram;Decoding;Tools;Mobile handsets;Internet;Engines;Speech recognition;Nahuatl;NMT;mobile;translation;attention;machine learning;CoreML;neural network;Mel spectrogram},
        Month = {Nov},
        Pages = {235-244},
        Title = {Towards the implementation of an Attention-based Neural Machine Translation with artificial pronunciation for Nahuatl as a mobile application},
        Year = {2020},
        Bdsk-Url-1 = {https://doi.org/10.1109/CONISOFT50191.2020.00041}
    }

    @article{springer-jcr,
        Author = {S. K. {Bello García} and E. {S{\'a}nchez Lucero} and E. {Bonilla Huerta} and J. C. {Hern{\'a}ndez Hern{\'a}ndez} and J. F. {Ramírez Cruz} and B. E. {Pedroza M{\'e}ndez}},
        Date-Added = {2021-08-22 17:05:11 -0500},
        Date-Modified = {2021-08-22 17:07:42 -0500},
        Journal = {Programming and Computer Software},
        Keywords = {machine translation; nahuatl; attention; application; transformers},
        Month = {Dec},
        Number = {8},
        Title = {Implementation of Neural Machine Translation for Nahuatl as a Web Platform: A focus on text translation},
        Volume = {47},
        Year = {2021}
    }

[MICAI-Springer](https://link.springer.com/chapter/10.1007%2F978-3-030-89820-5_10)

    @InProceedings{10.1007/978-3-030-89820-5_10,
        author="Bello Garc{\'i}a, Sergio Khalil
        and S{\'a}nchez Lucero, Eduardo
        and Bonilla Huerta, Edmundo
        and Hern{\'a}ndez Hern{\'a}ndez, Jos{\'e} Crisp{\'i}n
        and Ram{\'i}rez Cruz, Jos{\'e} Federico
        and Pedroza M{\'e}ndez, Blanca Estela",
        editor="Batyrshin, Ildar
        and Gelbukh, Alexander
        and Sidorov, Grigori",
        title="Nahuatl Neural Machine Translation Using Attention Based Architectures: A Comparative Analysis for RNNs and Transformers as a Mobile Application Service",
        booktitle="Advances in Soft Computing",
        year="2021",
        publisher="Springer International Publishing",
        address="Cham",
        pages="120--139",
        isbn="978-3-030-89820-5"
    }

    @article{ISP-RAS,
        Author = {Sergio. Khalil. {Bello García} and Eduardo. {S{\'a}nchez Lucero} and Edmundo. {Bonilla Huerta} and Jos{\'e}. Federico. {Ram{\'\i}rez Cruz} and Jos{\'e}. Crispín. {Hern{\'a}ndez Hern{\'a}ndez} and Blanca. Estela. {Pedroza M{\'e}ndez}},
        Date-Added = {2021-08-22 17:29:22 -0500},
        Date-Modified = {2021-08-22 17:57:28 -0500},
        Journal = {Proceedings of the Institute for System Programming of the RAS},
        Title = {Pushing the Text Nahuatl Neural Machine Translation Boundaries as a Mobile Application},
        Year = {2021}
    }
