# Reflect Columns in an Object, reversing the sign of all elements

`candisc` and `cancor` objects have coefficients for the X and Y and
weighted scores for these, whose signs are arbitrary, in the sense that
a given column can be reflected (multiplied by -1) without changing the
fit. But, often you will want to reverse the direction of one or more
dimensions for ease of interpretation.

This function allows you to reflect any columns of the variable
coefficients (and corresponding observation scores). This is often
useful for interpreting a biplot, for example when a component (often
the first) has all negative signs.

## Usage

``` r
reflect(object, columns = 1:2, ...)

# S3 method for class 'data.frame'
reflect(object, columns = 1:2, ...)

# S3 method for class 'cancor'
reflect(object, columns = 1:2, ...)

# S3 method for class 'candisc'
reflect(object, columns = 1:2, ...)
```

## Arguments

- object:

  An object whose columns are to be reflected

- columns:

  a vector of indices of the columns to reflect

- ...:

  Unused

## Value

The object with specified columns of the appropriate components
(variable coefficients, observation scores, ...) multiplied by -1.

## Details

`reflect` methods are available for:

- `data.frame`s, for numeric columns

- `"cancor"` objects, for the coefficients and scores of the `X` and `Y`
  variables

- `"candisc"` objects, for the coefficients, structure correlations and
  scores

Note that
[`plot.candisc()`](https://friendly.github.io/candisc/reference/candisc.md)
and
[`plot.candisc()`](https://friendly.github.io/candisc/reference/candisc.md)
can handle this internally using the argument `rev.axes`.

## Methods (by class)

- `reflect(data.frame)`: `"data.frame"` method.

- `reflect(cancor)`: `"cancor"` method.

- `reflect(candisc)`: `"candisc"` method.

## See also

[ggbiplot::reflect](http://friendly.github.io/ggbiplot/reference/reflect.md)
has similar methods for PCA-like objects

## Author

Michael Friendly

## Examples

``` r
# reflect cols in a data.frame
X <- data.frame(x1 = 1:4, x2 = 5:8)
reflect(X)
#>   x1 x2
#> 1 -1 -5
#> 2 -2 -6
#> 3 -3 -7
#> 4 -4 -8
reflect(X, 1)
#>   x1 x2
#> 1 -1  5
#> 2 -2  6
#> 3 -3  7
#> 4 -4  8
reflect(X, 2)
#>   x1 x2
#> 1  1 -5
#> 2  2 -6
#> 3  3 -7
#> 4  4 -8
cbind (X, letters[1:4]) |> reflect(1)
#>   x1 x2 letters[1:4]
#> 1 -1  5            a
#> 2 -2  6            b
#> 3 -3  7            c
#> 4 -4  8            d

# reflect a candisc 
iris.mod <- lm(cbind(Petal.Length, Sepal.Length, Petal.Width, Sepal.Width) ~ Species, data=iris)
iris.can <- candisc(iris.mod, data=iris)
coef(iris.can)
#>                    Can1        Can2
#> Petal.Length  0.9472572  0.40103782
#> Sepal.Length -0.4269548 -0.01240753
#> Petal.Width   0.5751608 -0.58103986
#> Sepal.Width  -0.5212417 -0.73526131
# reflect Can1
iris.can |> reflect(1) |> coef()
#>                    Can1        Can2
#> Petal.Length -0.9472572  0.40103782
#> Sepal.Length  0.4269548 -0.01240753
#> Petal.Width  -0.5751608 -0.58103986
#> Sepal.Width   0.5212417 -0.73526131

# reflect a cancor
data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables
Rohwer.can <- cancor(X, Y, set.names=c("PA", "Ability"))
coef(Rohwer)
#> NULL
Rohwer.can |> reflect() |> coef()
#>          Xcan1        Xcan2       Xcan3
#> n   0.07746734  0.046929646  0.13442728
#> s  -0.05421146 -0.111867775  0.23331362
#> ns -0.11348543 -0.221792097 -0.09291490
#> na  0.13877865  0.094120811 -0.05069181
#> ss  0.08919774  0.008243993 -0.03600015

```
