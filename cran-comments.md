## Test environments
* local Windows 11 x64, R 4.6.2 (ucrt)
* win-builder: R Under development (unstable) (PENDING)

## R CMD check results
0 errors | 0 warnings | 0 notes, locally (`--as-cran`) and on win-builder (R-devel) (PENDING)

## Version 1.1.3

This release combines 1.1.2 (not submitted) and 1.1.3; CRAN has 1.1.1.

* Bug fixes (1.1.2): `candisc()` and `candiscList()` gave an error for a term with a
  matrix predictor, such as `splines::ns(x, 3)` or `poly(x, 2)`. `summary.candisc()` and
  `plot.candisc()` now handle such terms, and `plot.candiscList()` finds terms whose names
  contain spaces.
* `heplot.candisc()`: the labels for group means can be moved with `means.pos`, passed on
  to `heplots::heplot()`, when two labels overlap. This requires heplots (>= 1.8.7), now
  on CRAN, so `Depends:` is raised to `heplots (>= 1.8.7)`.
* `heplot.candisc()` and `heplot3d.candisc()` gain a `factor.means` argument, so the
  group means can be omitted.
* Links to `datavis.ca`, which is offline, were replaced with DOIs.

## Reverse dependencies

We checked 6 reverse dependencies (Guerry, heplots, KnowBR, MorphoTools2,
MultivariateAnalysis, SurveyCC) with `revdepcheck`, comparing R CMD check results across
the CRAN (1.1.1) and dev (1.1.3) versions of this package.

* We saw 0 new problems
* We failed to check 0 packages

Two packages, `Guerry` and `heplots` (both of which I maintain), show a vignette ERROR
with both the CRAN and dev versions of candisc: a vignette refers to an image by a path
into the package source (`here::here("man", "figures", ...)`), which isn't found when the
vignette code is run in the revdep check. This is unrelated to candisc.
