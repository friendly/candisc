# Canonical Discriminant HE plots

These functions plot ellipses (or ellipsoids in 3D) in canonical
discriminant space representing the hypothesis and error
sums-of-squares-and-products matrices for terms in a multivariate linear
model. They provide a low-rank 2D (or 3D) view of the effects for that
term in the space of maximum discrimination.

## Usage

``` r
# S3 method for class 'candiscList'
heplot(mod, term, ask = interactive(), graphics = TRUE, ...)
```

## Arguments

- mod:

  A `candiscList` object for terms in a `mlm`

- term:

  The name of one term to be plotted for the `heplot` and `heplot3d`
  methods. If not specified, one plot is produced for each term in the
  `mlm` object.

- ask:

  If `TRUE` (the default), a menu of terms is presented; if ask is
  FALSE, canonical HE plots for all terms are produced.

- graphics:

  if `TRUE` (the default, when running interactively), then the menu of
  terms to plot is presented in a dialog box rather than as a text menu.

- ...:

  Arguments to be passed down

## Value

No useful value; used for the side-effect of producing canonical HE
plots.

## References

Friendly, M. (2006). Data Ellipses, HE Plots and Reduced-Rank Displays
for Multivariate Linear Models: SAS Software and Examples *Journal of
Statistical Software*, 17(6), 1-42. <https://www.jstatsoft.org/v17/i06/>
[doi:10.18637/jss.v017.i06](https://doi.org/10.18637/jss.v017.i06) .

Friendly, M. (2007). HE plots for Multivariate General Linear Models.
*Journal of Computational and Graphical Statistics*, **16**(2) 421–444.
<http://datavis.ca/papers/jcgs-heplots.pdf>,
[doi:10.1198/106186007X208407](https://doi.org/10.1198/106186007X208407)
.

## See also

[`candisc`](https://friendly.github.io/candisc/reference/candisc.md),
[`candiscList`](https://friendly.github.io/candisc/reference/candiscList.md),
[`heplot`](https://friendly.github.io/heplots/reference/heplot.html),
[`heplot3d`](https://friendly.github.io/heplots/reference/heplot3d.html)

## Author

Michael Friendly and John Fox
