# Wilks Lambda Tests for Canonical Correlations

Tests the sequential hypotheses that the \\i\\th canonical correlation
and all that follow it are zero, \$\$\rho_i = \rho\_{i+1} = \cdots =
0\$\$

## Usage

``` r
Wilks(object, ...)

# S3 method for class 'cancor'
Wilks(object, ...)

# S3 method for class 'candisc'
Wilks(object, ...)
```

## Arguments

- object:

  An object of class `"cancor""` or `"candisc""`

- ...:

  Other arguments passed to methods (not used)

## Value

A data.frame (of class `"anova"`) containing the test statistics

## Details

Wilks' Lambda values are calculated from the eigenvalues and converted
to F statistics using Rao's approximation.

## Methods (by class)

- `Wilks(cancor)`: `"cancor"` method.

- `Wilks(candisc)`: [`print()`](https://rdrr.io/r/base/print.html)
  method for `"candisc"` objects.

## References

Mardia, K. V., Kent, J. T. and Bibby, J. M. (1979). *Multivariate
Analysis*. London: Academic Press.

## See also

[`cancor()`](https://friendly.github.io/candisc/reference/cancor.md)

## Author

Michael Friendly

## Examples

``` r
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

cc <- cancor(X, Y, set.names=c("PA", "Ability"))
Wilks(cc)
#> 
#> Test of H0: The canonical correlations in the 
#> current row and all that follow are zero
#> 
#>      CanR LR test stat approx F numDF denDF   Pr(> F)    
#> 1 0.67033      0.44011   3.8961    15 168.8 5.535e-06 ***
#> 2 0.38366      0.79923   1.8379     8 124.0   0.07608 .  
#> 3 0.25065      0.93718   1.4078     3  63.0   0.24881    
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
iris.can <- candisc(iris.mod, data=iris)
Wilks(iris.can)
#> 
#> Test of H0: The canonical correlations in the 
#> current row and all that follow are zero
#> 
#>   LR test stat approx F numDF denDF   Pr(> F)    
#> 1      0.02344  199.145     8   288 < 2.2e-16 ***
#> 2      0.77797   13.794     3   145 5.794e-08 ***
#> ---
#> Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

```
