# Indices of observations in a model data frame

Find sequential indices for observations in a data frame corresponding
to the unique combinations of the levels of a given model term from a
model object or a data frame

## Usage

``` r
dataIndex(x, term)
```

## Arguments

- x:

  Either a data frame or a model object

- term:

  The name of one term in the model, consisting only of factors

## Value

A vector of indices.

## Author

Michael Friendly

## Examples

``` r
factors <- expand.grid(A=factor(1:3),B=factor(1:2),C=factor(1:2))
n <- nrow(factors)
responses <-data.frame(Y1=10+round(10*rnorm(n)),Y2=10+round(10*rnorm(n)))

test <- data.frame(factors, responses)
mod <- lm(cbind(Y1,Y2) ~ A*B, data=test)

dataIndex(mod, "A")
#>  [1] 1 2 3 1 2 3 1 2 3 1 2 3
dataIndex(mod, "A:B")
#>  [1] 1 2 3 4 5 6 1 2 3 4 5 6

```
