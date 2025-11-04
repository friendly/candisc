## Test environments
* local Windows 10, 4.5.1 (2025-06-13 ucrt)
* winbuilder: R Under development (unstable) (2025-11-03 r88979 ucrt)

## R CMD check results
There were no ERRORs, WARNINGs or NOTES 

## reverse dependencies

> devtools::revdep()
> revdep()
[1] "Guerry"               "heplots"              "KnowBR"               "MorphoTools2"        
[5] "MultivariateAnalysis" "SurveyCC"


## revdepcheck results

> revdepcheck::revdep_check(num_workers = 4)

We checked 6 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages

## Comments

## Version 1.0.0

This is a major release, adding methods for linear/quadratic discriminant analysis and improving package documentation

* Added `predict_discrim()` as a wrapper to `MASS::predict.lda()` returning a data.frame
* Added `plot_discrim()` to plot decision regions for discriminant analysis using contours or background tiles
* Added `cor_lda()` to calculate structure correlations between variables and discriminant scores
* Added `scores.lda()` method to extract discriminant scores
* Added `reflect()` generic to allow axis reversal for candisc and cancor objects
* Improved documentation of a number of functions
* Added additional plots to dataset documentation
* Now use `Roxygen: list(markdown = TRUE)` in DESCRIPTION
* Ran `roxygen2md(scope = "simple")` for first pass of roxygen conversion to markdown, others converted by hand



