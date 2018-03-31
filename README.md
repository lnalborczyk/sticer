
Sequential Testing with Information Criteria and Evidence Ratios
================================================================

<!--
[![CRAN status](https://www.r-pkg.org/badges/version/ESTER)](https://cran.r-project.org/package=ESTER)
-->
[![Build Status](https://travis-ci.org/lnalborczyk/sticer.svg?branch=master)](https://travis-ci.org/lnalborczyk/sticer)

The `sticer` package implements sequential testing based on evidence ratios computed from the weights of a set of models. These weights are being computed using either the Akaike Information Criterion (AIC) or the Bayesian Information Criterion (BIC).

Installation
------------

You can install the latest version from CRAN using:

``` r
install.packages("ESTER") # ESTER is the previous name of sticer
```

Or the development version from Github with:

``` r
if (!require("devtools") ) install.packages("devtools")
devtools::install_github("lnalborczyk/sticer", dependencies = TRUE)
```

Different questions
-------------------

1.  **Simulation**. What evolution of evidence ratios should I reasonnably expect for different effect sizes ?

2.  **Observed data**. When to stop recruiting participants ?

Simulation
----------

The `simER` function runs a simulated study in which we compare two independent groups, for various effect sizes (`cohensd`) until a maximum sample size (`nmax`). The `nmin` argument serves to specify from which participant we want to start doing sequential testing (we usually recommend to avoid `nmin` &lt; 10). We can define a `boundary` at which we would like to stop the sequential testing, as well as how many simulations we want to evaluate (`nsims`).

``` r
library(sticer)
simER(cohensd = 0.8, nmin = 20, nmax = 100, boundary = 10, nsims = 100, ic = aic)
```

Observed data
-------------

On the other hand (and perhaps more interestingly), `sticer` can be used to do sequential testing on your own data. You can study the evolution of sequential ERs using the `seqER` function.

``` r
data(mtcars)
mod1 <- lm(mpg ~ cyl, mtcars)
mod2 <- lm(mpg ~ cyl + disp, mtcars)
seqER(ic = aic, mod1, mod2, nmin = 10)
```

In addition, `seqER` allows you to study the behaviour of sequential ERs computed on your own data, along with sequential ERs computed on permutation samples. This feature might be useful to study to what extent the evolution of evidence ratios you observed on the original sample is dependent to the order of the observations.

``` r
seqER(ic = aic, mod1, mod2, nmin = 10, nsims = 10)
```

More detailed information can be found in the main vignette, available online [here](https://rawgit.com/lnalborczyk/ESTER/master/inst/doc/sticer.html), or by typing `vignette("sticer")` in the console.
