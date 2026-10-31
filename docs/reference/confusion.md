# Confusion matrix for LDA / QDA

Calculates a table of the actual vs. predicted class of all observations
in a dataset for objects resulting from
[`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html) or
[`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html)

## Usage

``` r
confusion(object, ...)

# S3 method for class 'lda'
confusion(object, ...)

# S3 method for class 'qda'
confusion(object, ...)

# S3 method for class 'confusion'
print(x, digits = 2, ...)
```

## Arguments

- object:

  An object of class `lda` or `qda`

- ...:

  Arguments passed to methods

- x:

  A `confusion` object

- digits:

  Number of decimal places for accuracy and error rates

## Value

An object of class `c("confusion", "table")`, a table of frequencies of
actual vs. predicted class with attributes `accuracy` and `error` giving
the overall rates of correct and incorrect prediction.

## See also

[`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html),
[`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html)

## Examples

``` r
library(MASS)
#> 
#> Attaching package: 'MASS'
#> The following object is masked from 'package:dplyr':
#> 
#>     select
iris.lda <- lda(Species ~ ., iris)
confusion(iris.lda)
#>             predicted
#> actual       setosa versicolor virginica
#>   setosa         50          0         0
#>   versicolor      0         48         2
#>   virginica       0          1        49
#> 
#> Accuracy:  98.00%
#> Error:      2.00%

iris.qda <- qda(Species ~ ., iris)
confusion(iris.qda)
#>             predicted
#> actual       setosa versicolor virginica
#>   setosa         50          0         0
#>   versicolor      0         48         2
#>   virginica       0          1        49
#> 
#> Accuracy:  98.00%
#> Error:      2.00%
```
