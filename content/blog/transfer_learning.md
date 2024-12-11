+++
title = "Transfer Learning"
date = "2024-11-27"
draft = false
slug = ''
categories = ['']
tags = ['']
headline = 'É tudo Fine-Tuning?'
readingtime = true
katex = true
+++

Vamos começar por um exemplo. Algumas pessoas sabem tocar um instrumento muito bem, suponha que seja o Violino, e, quando tentam aprender um novo instrumento de cordas, tem mais facilidade em relação a outras pessoas que nunca foram expostas a instrumentos musicais antes. Por que isso acontece? O nosso cerébro aprende sobre o instrumento, ritmo, configuração das cordas e assim fica mais fácil generalizar o conhecimento para outros instrumentos.

## O que é Transfer Learning?

De forma similar com as pessoas que aprenderam a tocar piano, as máquinas também tem várias formas de aprender e guardar esse conhecimento. Seria muito útil se pudessemos reutilizar o conhecimento adquirido de alguma forma. Transfer Learning é uma área de Aprendizado de Máquina que estuda como reutilizar experiências prévias de modelos para novas propostas. É necessário que esse conhecimento seja útil/relacionado de alguma forma com a nova proposta.

## Vantagens de aplicar métodos de Transfer Learning

Pode diminuir seus custos computacionais, pegada de carbono, permitir utilizar modelos estado-da-arte sem precisar treinar do zero além de permitir o treinamento de modelos com um volume limitado de dados.

## Matematiquês

Vamos definir algumas coisas que serão úteis:

- Domínio $D$ é representado por um espaço de features $X$ e uma distribuição de probabilidade
- Tarefa $T$ é definida por um espaço de rótulos $Y$ e uma função preditiva $f(.)$

### Definição de TL

Dado um domínio $D_s$ e uma tarefa correspondente $T_s$, um domínio objetivo $D_t$ e uma tarefa objetiva $T_t$, TL busca incrementar o aprendizado em $D_t$ com informações obtidas de $D_s$ e $T_s$, em que $D_t \ne D_s$ ou $T_t \ne T_s$. Ufa!

## Exemplo para esclarecer: definição de classes gramaticais

POS tagging é o nome de um processo que define classes gramaticais com a parte correspondente de um trecho de um texto baseado na definição da palavra e sua definição. Por exemplo, na frase 'Eu sou feliz no Brasil'. Eu é Pronome, sou é verbo, feliz é adjetivo e assim por diante.

Assuma que temos um dataset em Espanhol e um Dataset em Português. 

### $X_t \ne X_s$

Digamos que queremos fazer definição de classes gramaticais em documentos brasileiros (em PT). Assumindo que Espanhol e Português são línguas semelhantes, podemos utilizar o conhecimento de ricos datasets em Espanhol para essa tarefa, apesar de que o nosso espaço de features seja totalmente diferente.

### $P(X_t) \ne P(X_s)$

Agora que imagine que precisamos fazer definição de classes em livros de receitas utilizando o nosso dataset em PT. Por mais que esses documentos estejam escritos na mesma língua, eles possuem o foco em tópicos diferentes, então a distribuição e frequência das palavras será diferente. Eu espero que a palavra farinha apareça muito mais nas receitas do que no dataset de forma geral. 

### $Y_t \ne Y_s$

Suponha que desejamos classificar os textos do nosso dataset entre políticos ou não, porém já existe uma separação utilizando as classes textos jornalísticos ou literários. Dessa forma podemos reaproveitar o conhecimento para aumentar a acurácia da nova proposta.

## Tipos de Transfer Learning

### Baseado em Instância

Esse método busca reponderar as amostras no domínio de origem para corrigir diferenças de distribuição. Isso ajuda o modelo a aprender apenas informações relevantes do domínio de origem e funciona melhor quando ambas distribuições pertencem ao mesmo domínio.

Uma forma de fazer isso é dar maior importância a amostras do domínio de origem que sejam mais similares a amostras do domínio de destino.

### Baseado em Features

De forma similar, busca reduzir a diferença entre as distribuições do domínio origem e destino através de uma transformação. Aqui, qualquer transformação pode ser realizada, por exemplo, para um espaço latente de dimensão menor, que pososui distribuição marginal mais parecida entre os domínios. Algo como aprendizado de representação.

### Baseado em Parâmetros

Busca transferir o conhecimento através de reaproveitar parâmetros dos modelos de origem. O exemplo mais comum é fine-tuning.

### Referências
- [Georgian Impact - Transfer Learning](https://medium.com/georgian-impact-blog/transfer-learning-part-1-ed0c174ad6e7)
- A Survey on Transfer Learning, Sinno Pan and Qiang Yang
