+++
title = "Creating a Chess Bot with Data Science"
date = "2023-12-25"
draft = true
slug = ''
categories = ['']
tags = ['']
headline = 'A story about chess bots and how I made mine'
readingtime = true
+++

Unite two passions like chess and computers is an old hobby that started long time ago when I created an website to agregate chess info around the net. There was a long time ago, and having the opportunity to make another project involving chess make me curious. 

The youtuber [Sebastian Lague](https://www.youtube.com/c/SebastianLague) developed a challenge between its followers with the objective of creating the most powerful Chess Bot within a limit of characters in C#. Together with some university colleagues, we created the [Saint Charles Bot](https://github.com/icmc-data/tiny-chess-bots) (named after our campus city).

But the bot did not work as expected. Fitting a Neural Network, our main goal, into the limit of 2048 tokens made by Sebastian turned out to be a pain. In the end, we sent a simple version of the bot just for fun. The story did not end there, tough. After the challenge, we trascribed the code to Python to create Pyrarucu. Its name is based on the powerful chess bots Rybka, Stockfish, which references fishes, with a touch of brasility. You can challenge it for a game at [Lichess](https://lichess.org/@/Pyrarucu).

In this post, I want to give a idea of the main challenges and tips of building a chess bot with machine learning.

#### Dataset
In this project I choosen to work with supervised learning techniques. The dataset [Chess Evaluations](https://www.kaggle.com/datasets/ronakbadhe/chess-evaluations) have millions of [FEN](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation) positions with theier respective analizys by a strong chess computer [Stockfish](https://stockfishchess.org/) which will work as training data for my Neural Network.

#### Bitboard
A bitboard is a very common way of storing bits in computer games, where each bit represents a piece or a space. In our case, the bitboard is a tool that helps produce a vector representation of the Chess board.

There are 12 different types of pieces in the game, including the white pawn, the white bishop, ... and the black king. Thus, each piece can receive its representation in bitboards, which is a vector of size 64 (there is a space for each square on the board) and receives the value 1 if the piece is located there and 0 otherwise.

![../img/bitboard.gif](../img/bitboard.gif)


## Notebooks
Notebooks jupyter são ótimas ferramentas para auxiliar no desenvolvimento de um modelo. Assim, o desenvolvimento e treinamento estão em [notebooks/01_training.ipynb](notebooks/01_training.ipynb). Não hesite em realizar contribuições e testes por lá.

## O cérebro do Pyrarucu
A parte do processamento está no arquivo [strategies.py](strategies.py), mais especificamente na classe `MyBot()`.
Todas as mudanças exceto quanto a notebooks devem ser nesse arquivo.


### Features
- Função de Pesquisa com Alpha Beta Pruning `alpha_beta_pruning()`
- Função de Análise simples `simple_evaluation()`
- Função de Análise com Rede Neural `ml_evaluation()`

Para compreender um pouco melhor como bots de Xadrez funcionam, vamos explicar alguns conceitos:




Esses vetores, quando empilhados (formando um único vetor de tamanho 12x64) podem ser utilizados para treinar algoritmos de aprendizado de máquina.

#### Função de Análise
A função de análise `def evaluation()` recebe como entrada um tabuleiro de xadrez e retorna um valor que indica a situação atual do jogo. É comum que um valor positivo represente vantagem das brancas e vice-versa.

![resources/evaluation.png](resources/evaluation.png)

A magnitude da função é dada de tal forma que 1 ponto de vantagem é equivalente a um peão de vantagem.

#### Função de Pesquisa
A partir da função de análise, buscaremos encontrar qual lance leva a melhor posição. 

Para isso, podemos criar uma árvore onde cada nó é uma posição com um valor assinalado pela função de análise. A partir da posição atual - o nó raiz da nossa árvore - diferentes lances levam a diferentes posições, que por sua vez podem ser vantajosas ou não.
Considerando que o adversário sempre fará os melhores lances, a função de pesquisa encontra o lance que nos dá a melhor posição independente da resposta do oponente.

#### MinMax 
Uma forma muito comum de encontrar o caminho descrito no tópico anterior é através do algoritmo MinMax.
![Tree with minmax algorithm](resources/minmax.png)

De forma simplificada, o algoritmo encontra o caminho que busca maximizar as posições vantajosas ao mesmo tempo que minimiza as posições com análise ruim.

#### Heurísticas 
As heurísticas desempenham um papel importante na hora de ajudar o programador a encontrar uma solução aproximada para um problema incerto. Para os bots de Xadrez, são bem úteis para diminuir o tempo de pesquisa e normalmente demandam conhecimento do jogo.

Por exemplo, podemos implementar uma heurística que priorize lances de xeque no turno do bot.
Atualmente, é utilizada uma heurística para ordenar os movimentos por importância antes de analisar cada um. Assim, espera-se que haja uma melhora significativa no tempo de raciocínio do Pyrarucu. 

#### Dataset Chess Evaluations
Um dataset é uma base de dados imensa que pode ser utilizada para o treinamento de modelos de aprendizado de máquina. O dataset [Chess Evaluations](https://www.kaggle.com/datasets/ronakbadhe/chess-evaluations) possui milhares de posições no formato [FEN](https://en.wikipedia.org/wiki/Forsyth%E2%80%93Edwards_Notation) acompanhadas de respectivas análises pelo computador [Stockfish](https://stockfishchess.org/).

#### Rede Neural
Na nossa aplicação, atualmente utilizamos uma função de análise baseada em redes neurais que possui a etapa de treinamento com o dataset descrito no tópico passado.

Inicialmente transformamos os tabuleiros em diversos bitboards através da função `fen_to_bit_array()`. Com as representações vetoriais, podemos treinar a nossa rede neural para predizer o resultado esperado de acordo com o dataset.

Sequência de passos para construir os bitboards, treinar a rede neural e efetuar uma predição.
``` python
X = df['FEN'].apply(fen_to_bit_array).to_list()
y = df['Evaluation']
reg = MLPRegressor().fit(X, Y)

reg.predict(X_test)
```

Com o qual obtemos o valor
``` bash
0.07698299
```

## Authors
- [@vitorfrois](https://www.github.com/vitorfrois)
- [@MurilloMMartins](https://www.github.com/MurilloMMartins)

## Referências
[Chess Programming Wiki](https://www.chessprogramming.org/Main_Page)
[Stanford CS221](https://stanford.edu/~cpiech/cs221/apps/deepBlue.html)
[Coding Adventure: Making a Better Chess Bot](https://www.youtube.com/watch?v=_vqlIPDR2TU)
