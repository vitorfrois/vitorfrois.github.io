+++
title = "Vae"
date = "2024-11-27"
draft = true
slug = ''
categories = ['']
tags = ['']
headline = ''
readingtime = true
katex = true
+++

# Auto Encoder Variacional (VAEs)
VAEs buscam encontrar uma distribuição de probabilidade sobre os dados $x$. Assim, é possível gerar novos dados utilizando essa distribuição.

## Modelos de Variável Latente
Os modelos de variável latente fazem isso utilizando variável latente $z$. Podemos marginalizar a distribuição de probabilidade conjunta $P(x, z)$ para obter $P(x)=\int P(x,z)dz$, que pode ser reeescrito como 


###