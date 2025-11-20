# Canonical Redundancy Analysis

Calculates indices of redundancy (Stewart & Love, 1968) from a canonical
correlation analysis. These give the proportion of variances of the
variables in each set (X and Y) which are accounted for by the variables
in the other set through the canonical variates.

## Usage

``` r
redundancy(object, ...)

# S3 method for class 'cancor.redundancy'
print(x, digits = max(getOption("digits") - 3, 3), ...)
```

## Arguments

- object:

  A `"cancor"` object

- ...:

  Other arguments

- x:

  A `"cancor.redundancy"` for the `print` method.

- digits:

  Number of digits to print

## Value

An object of class `"cancor.redundancy"`, a list with the following 5
components:

- Xcan.redun:

  Canonical redundancies for the X variables, i.e., the total fraction
  of X variance accounted for by the Y variables through each canonical
  variate.

- Ycan.redun:

  Canonical redundancies for the Y variables

- X.redun:

  Total canonical redundancy for the X variables, i.e., the sum of
  `Xcan.redun`.

- Y.redun:

  Total canonical redundancy for the Y variables

- set.names:

  names for the X and Y sets of variables

## Details

The term "redundancy analysis" has a different interpretation and
implementation in the environmental ecology literature, such as the
vegan. In that context, each \\Y_i\\ variable is regressed separately on
the predictors in \\X\\, to give fitted values \\\widehat{Y} =
\[\widehat{Y}\_1, \widehat{Y}\_2, \dots\\. Then a PCA of \\\widehat{Y}\\
is carried out to determine a reduced-rank structure of the predictions.

## Functions

- `print(cancor.redundancy)`:
  [`print()`](https://rdrr.io/r/base/print.html) method for
  `"cancor.redundancy"` objects.

## References

Muller K. E. (1981). Relationships between redundancy analysis,
canonical correlation, and multivariate regression. *Psychometrika*,
**46**(2), 139-42.

Stewart, D. and Love, W. (1968). A general canonical correlation index.
*Psychological Bulletin*, 70, 160-163.

Brainder, "Redundancy in canonical correlation analysis",
<https://brainder.org/2019/12/27/redundancy-in-canonical-correlation-analysis/>

## See also

\\ [`cancor()`](https://friendly.github.io/candisc/reference/cancor.md)

## Author

Michael Friendly

## Examples

``` r
  data(Rohwer, package="heplots")
X <- as.matrix(Rohwer[,6:10])  # the PA tests
Y <- as.matrix(Rohwer[,3:5])   # the aptitude/ability variables

cc <- cancor(X, Y, set.names=c("PA", "Ability"))

redundancy(cc)
#> 
#> Redundancies for the PA variables & total X canonical redundancy
#> 
#>     Xcan1     Xcan2     Xcan3 total X|Y 
#>  0.173424  0.042113  0.007966  0.223503 
#> 
#> Redundancies for the Ability variables & total Y canonical redundancy
#> 
#>     Ycan1     Ycan2     Ycan3 total Y|X 
#>   0.22491   0.03688   0.01564   0.27743 
## 
## Redundancies for the PA variables & total X canonical redundancy
## 
##     Xcan1     Xcan2     Xcan3 total X|Y 
##   0.17342   0.04211   0.00797   0.22350 
## 
## Redundancies for the Ability variables & total Y canonical redundancy
## 
##     Ycan1     Ycan2     Ycan3 total Y|X 
##    0.2249    0.0369    0.0156    0.2774 

```
