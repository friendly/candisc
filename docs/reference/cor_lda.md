# Calculate Structure Correlations from Discriminant Analysis

`cor_lda()` calculates the "structure" correlations between the observed
variables and the discriminant dimension scores from a linear
discriminant analysis provided by
[`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html). These more
directly assess the direction and strength of the relations between the
two sets than do the `scaling` weights returned by `lda()`. They are
useful for plotting the discriminant scores, showing the contributions
of the variables by vectors.

## Usage

``` r
cor_lda(
  object,
  prior = object$prior,
  dimen,
  method = c("pearson", "kendall", "spearman"),
  ...
)
```

## Arguments

- object:

  An object of class `"lda"` such as results from
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html)

- prior:

  The prior probabilities of the classes. By default, taken to be the
  proportions in what was set in the call to
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html)

- dimen:

  The dimension of the space to be used. If this is less than the number
  of available dimensions, \\\min(p, ng-1)\\, only the first `dimen`
  discriminant components are used.

- method:

  a character string indicating which correlation coefficient is to be
  computed. One of `"pearson"` (default), `"kendall"`, or `"spearman"`:
  can be abbreviated. See
  [`stats::cor()`](https://rdrr.io/r/stats/cor.html) for details

- ...:

  other arguments (presently ignored)

## Value

      a numeric matrix of correlations, of size `nv` = number of predictor variables * `dimen`

## See also

[`predict_discrim()`](https://friendly.github.io/candisc/reference/predict_discrim.md),
[`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html),
[`stats::cor()`](https://rdrr.io/r/stats/cor.html)

## Author

Michael Friendly

## Examples

``` r
library(candisc)
library(MASS)   # for lda()
#> 
#> Attaching package: 'MASS'
#> The following object is masked from 'package:dplyr':
#> 
#>     select

iris.lda <- lda(Species ~ ., iris)
cor_lda(iris.lda)
#>                     LD1         LD2
#> Sepal.Length -0.7918878 -0.21759312
#> Sepal.Width   0.5307590 -0.75798931
#> Petal.Length -0.9849513 -0.04603709
#> Petal.Width  -0.9728120 -0.22290236
```
