# Transform a Multivariate Linear model `mlm` to a Canonical Representation

This function uses
[`candisc()`](https://friendly.github.io/candisc/reference/candisc.md)
to transform the responses in a multivariate linear model to scores on
canonical variables for a given term and then uses those scores as
responses in a linear (lm) or multivariate linear model (mlm).

The function constructs a model formula of the form `Can ~ terms` where
Can is the canonical score(s) and terms are the terms in the original
mlm, then runs lm() with that formula.

## Usage

``` r
can_lm(mod, term, ...)
```

## Arguments

- mod:

  A `mlm` object

- term:

  One term in that model

- ...:

  Arguments passed to
  [`candisc()`](https://friendly.github.io/candisc/reference/candisc.md)

## Value

A `lm` object if `term` is a rank 1 hypothesis, otherwise a `mlm` object

## See also

[`candisc()`](https://friendly.github.io/candisc/reference/candisc.md),
[`cancor()`](https://friendly.github.io/candisc/reference/cancor.md)

## Author

Michael Friendly

## Examples

``` r
iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
iris.can <- can_lm(iris.mod, "Species")
iris.can
#> 
#> Call:
#> lm(formula = cbind(Can1, Can2) ~ Species, data = scores)
#> 
#> Coefficients:
#>                    Can1     Can2   
#> (Intercept)        -7.6076  -0.2151
#> Speciesversicolor   9.4326   0.9430
#> Speciesvirginica   13.3902  -0.2976
#> 
car::Anova(iris.mod)
#> 
#> Type II MANOVA Tests: Pillai test statistic
#>         Df test stat approx F num Df den Df    Pr(>F)    
#> Species  2    1.1919   53.466      8    290 < 2.2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
car::Anova(iris.can)
#> 
#> Type II MANOVA Tests: Pillai test statistic
#>         Df test stat approx F num Df den Df    Pr(>F)    
#> Species  2    1.1919   108.41      4    294 < 2.2e-16 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```
