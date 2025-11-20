# Predicted values for discriminant analysis

`predict_discrim` calculates predicted class membership values for a
linear or quadratic discriminant analysis, returning a `data.frame`
suitable for graphing or other analysis.

## Usage

``` r
predict_discrim(
  object,
  newdata,
  prior = object$prior,
  dimen,
  scores = FALSE,
  posterior = FALSE,
  ...
)
```

## Arguments

- object:

  An object of class `"lda"` or `"qda"` such as results from
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html) or
  [`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html)

- newdata:

  A data frame of cases to be classified or, if `object` has a formula,
  a data frame with columns of the same names as the variables used. A
  vector will be interpreted as a row vector. If `newdata` is missing,
  an attempt will be made to retrieve the data used to fit the `lda`
  object.

- prior:

  The prior probabilities of the classes. By default, taken to be the
  proportions in what was set in the call to
  [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html) or
  [`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html)

- dimen:

  The dimension of the space to be used. If this is less than the number
  of available dimensions, \\\min(p, ng-1)\\, only the first `dimen`
  discriminant components are used. (This argument is not yet
  implemented because
  [`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html) does not
  support this.)

- scores:

  A logical. If `TRUE`, the discriminant scores of the cases in
  `newdata` are appended as additional columns in the the result, with
  names `LD1`, `LD2`, ...

- posterior:

  Either a logical or the character string `"max"`. If `TRUE`, the
  posterior probabilities for all classes are included as columns named
  for the classes. If `FALSE`, these are omitted. If `"max"`, the
  maximum value of the probabilities across the classes are included,
  with the variable name `"maxp"`.

- ...:

  arguments based from or to other methods, not yet used here

## Value

A `data.frame`, containing the the predicted class of the observations
(named for the class in the model) and values of the `newdata`
variables. Other variables included are determined by the `scores` and
`posterior` arguments.
[`rownames()`](https://rdrr.io/r/base/colnames.html) in the result are
inherited from those in `newdata`.

## Details

The [`predict()`](https://rdrr.io/r/stats/predict.html) methods provided
for [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html) and
[`MASS::qda()`](https://rdrr.io/pkg/MASS/man/qda.html) are a mess,
because they return their results as a list, with components `class`,
`posterior` and `x`. This function is designed as a wrapper on those to
return results in a more consistent and flexible way.

For use in graphs, where you want to show the classification boundaries
or regions, you should supply a `newdata` data frame consisting of two
focal variables which are varied over their ranges, with the remaining
variables used in the discriminant analysis held fixed at typical
values.

Using the `scores` argument, the function also returns the scores on the
discriminant functions. This is only available for linear discriminant
analysis with [`MASS::lda()`](https://rdrr.io/pkg/MASS/man/lda.html).

## Examples

``` r
library(candisc)
library(MASS)   # for lda()

iris.lda <- lda(Species ~ ., iris)
pred_iris <- predict_discrim(iris.lda)
names(pred_iris)
#> [1] "Species"      "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 

# include scores, exclude posterior
pred_iris <- predict_discrim(iris.lda, scores = TRUE, posterior = FALSE)
names(pred_iris)
#> [1] "Species"      "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
#> [6] "LD1"          "LD2"         

data(peng, package="heplots")
peng.lda <- lda(species ~ bill_length + bill_depth + flipper_length + body_mass, 
                data = peng)
peng_pred <- predict_discrim(peng.lda, scores = TRUE)
str(peng_pred)
#> 'data.frame':    333 obs. of  7 variables:
#>  $ species       : Factor w/ 3 levels "Adelie","Chinstrap",..: 1 1 1 1 1 1 1 1 1 1 ...
#>  $ bill_length   : num  39.1 39.5 40.3 36.7 39.3 38.9 39.2 41.1 38.6 34.6 ...
#>  $ bill_depth    : num  18.7 17.4 18 19.3 20.6 17.8 19.6 17.6 21.2 21.1 ...
#>  $ flipper_length: num  181 186 195 193 190 181 195 182 191 198 ...
#>  $ body_mass     : num  3750 3800 3250 3450 3650 ...
#>  $ LD1           : num  4.32 2.44 2.98 4.54 5.66 ...
#>  $ LD2           : num  0.967 0.97 -0.168 1.626 0.824 ...
```
