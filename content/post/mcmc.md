+++
title = "Monte Carlo Markov Chains and the Metropolis Algorithm"
date = "2024-07-18"
draft = false
slug = 'mcmc'
tags = ['Statistics', 'Monte Carlo', 'Metropolis', 'Markov Chains', 'Ising']
headline = 'As a person born in the city of Montes Claros, I am a bit confused every time I read the name Monte Carlo. It is pretty useful though.'
readingtime = false
katex = true
+++

## ~~Montes Claros~~ Monte Carlo method

When talking about stochastic experiments, it is important to know different realizations can lead to different final results. Monte Carlo method proposes to repeat the experiment and measure the average between them. 

If we throw a dice, the expected value is 3.5. Altough, in a single realization, this could not be the result. After throwing a dice a million times and averaging the obtained values, we should come to a result equal to the theoretical one.

## Markov Chains

A Markov Chain is defined by a serie of events in which the probability of the next event will depend only on the probability of the state of the current event. This will be a expressive difference from the Monte Carlo method where the samples are statistically independent, those in MCMC are correlated: as you might have expected, the next sample depends on the current one.

## Monte Carlo Markov Chains

Or MCMC, and they are not exactly the same thing as traditional Monte Carlo method. The are a class of algorithms for **sampling probability distributions**. Each Markov step in the process is sampling the target distribution, and then, the more steps, more samples, and more accurate is the method.

In other words, given a unknown distribution, we can construct a set of samples that lies on the range of possible outcomes and spend a amount of (markovian) steps in each state/interval proportional to the actual density of the distribution.

### Very simple MCMC example

Lets say we want to discover the probability of sunny P(S) and rainy P(R) days at Montes Claros. We have some information, conditional probabilities about the weather.

$$
\begin{equation}
    P(S_{t+1}|R_t) = 0.5 \\\
    P(R_{t+1}|R_t) = 0.5 \\\
    P(R_{t+1}|S_t) = 0.1 \\\
    P(S_{t+1}|S_t) = 0.9 \\\
\end{equation}
$$

The system is irreducible (there is a single communicating state - or I can reach any state out of anywhere) and aperiodic (there is non defined pattern for visiting states). Here, we begin at a random state and randomly walk through the Markov Chain. At an infinitely high number of states we obtain a stationary distribution \\(\pi\\) with \\(\pi(S)=0.833\\) and \\(\pi(S)=0.166\\) 

## Metropolis Algorithm
MCMC are only a class of methods that have diverse implementations. One of the most common implemetations is the Metropolis Algorithm. 

Lets remember our objective is to sample from a unknown distribution, lets call it \\(p(x)\\). We want to estimate it given a similar distribution \\(f(x)\\) where they differ only by a constant, this is \\(p(x)=f(x)/C\\).
MCMC suggests that after some **burn-in** steps (these are like steps until we get in track), we will be sampling from \\(p(x)\\).

$$
\begin{equation}
X_0 \rarr X_1 \rarr ... \rarr X_n \rarr X_{n+1} \\\
\end{equation}
$$

Looks easy. Below, we will see that given a state \\(a\\) and a candidate \\(b\\), we **should** go from \\(a\\) to \\(b\\) if \\(b\\) is more probable. And if the state \\(b\\) is less probable, we **maybe** can go, according to the acceptance probability. 

### 1. Sample from an easier distribution \\(g\\)
Normal looks fine. Lets compute \\(g(x_{t+1}|x_t) = N(x_t, \sigma ^2 )\\).\\(g(x_{t+1}|x_t)\\) is not our definite next step. Actually, we need to compute an acceptance probability.

### 2. Accept (or not) the sample
Call the acceptance probability \\(A(x_t \rarr x_{t+1})\\) and the transition probability  \\(T(x_t \rarr x_{t+1})$

If the so called detailed balanced equation
$$p(a)T(a \rarr b) = p(b)T(b \rarr a)$$
is true, then it should be garanteed that MCMC converges to our \\(p(x)\\). 

We have to substitute \\(p(x)\\) in the equation and the transition probability by the probability of proposing the state change and probability of accepting. It follows:
$$
\frac{f(a)}{C} g(b|a)A(a \rarr b) = \frac{f(b)}{C} g(a|b)A(b \rarr a)
$$

Rewriting using ratios (the constant C will cancel):
$$
\frac{A(a \rarr b)}{A(b \rarr a)} = \frac{f(b)}{f(a)} \frac{g(a|b)}{g(b|a)}
$$

And finally naming the right side fractions:
$$
\frac{A(a \rarr b)}{A(b \rarr a)} = r_f r_g
$$

Finally, we can execute the acceptance or not of our state transition.
- if \\(r_f r_g \lt 1\\) then
$$
    A(a \rarr b) = r_f r_g \\\
    A(b \rarr a) = 1
$$
- else 
$$
    A(a \rarr b) = 1 \\\
    A(b \rarr a) = \frac{1}{r_f r_g}
$$

### 3. Metropolis case
In the metropolis case (differently from the Metropolis-Hastings algorithm), \\(g\\) is a simmetric probability distribution - a Gaussian e.g. Then, \\(g(a|b) = g(b|a)\\), allowing us to rewrite the acceptance function as

$$
A(a \rarr b) = max(1, \frac{f(b)}{f(a)}) = max(1, \frac{p(b)}{p(a)})
$$

## Applications and conclusions

MCMC is widely used for approximating numerical solutions for integrals and draw posterior samples in bayesian inference. Metropolis algorithm is widely used in simulations, and I pretend to follow this post with an example of its usage and implementation in the Ising model simulation.

## References
- [Data Witch Metropolis Hastings](https://blog.djnavarro.net/posts/2023-04-12_metropolis-hastings/)
- [ritvikmath Metropolis-Hastings](https://www.youtube.com/watch?v=yCv2N7wGDCw)
- [Michael Pyrcz MCMC](https://www.youtube.com/watch?v=7QX-yVboLhk)