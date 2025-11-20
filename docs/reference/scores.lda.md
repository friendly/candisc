# Extract Observation Discriminant Scores for Linear Discriminant Analysis

This is a thin wrapper for
[`predict_discrim()`](https://friendly.github.io/candisc/reference/predict_discrim.md)
to provide a
[`scores()`](https://friendly.github.io/candisc/reference/cancor.md)
method for discriminant analysis from
[`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html).

## Usage

``` r
# S3 method for class 'lda'
scores(x, prior = x$prior, dimen, ...)
```

## Arguments

- x:

  An object of class `"lda"` such as results from
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html)

- prior:

  The prior probabilities of the classes. By default, taken to be the
  proportions in what was set in the call to
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html)

- dimen:

  The dimension of the space to be used. If this is less than the number
  of available dimensions, \\min(p, ng-1)\\, only the first `dimen`
  discriminant components are used.

- ...:

  Unused; for compatibility with the generic

## Value

a data frame for the observations with columns `LD1`, `LD2`, ... for the
discriminant dimensions

## See also

[`predict_discrim()`](https://friendly.github.io/candisc/reference/predict_discrim.md),
[`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html)

## Author

Michael Friendly

## Examples

``` r
library(MASS)   # for lda()

iris.lda <- lda(Species ~ ., iris)
scores(iris.lda) |>
   str()
#> 'data.frame':    150 obs. of  2 variables:
#>  $ LD1: num  8.06 7.13 7.49 6.81 8.13 ...
#>  $ LD2: num  -0.3 0.787 0.265 0.671 -0.514 ...
 
```
