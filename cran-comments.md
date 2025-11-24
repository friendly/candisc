## Test environments
* local Windows 10, 4.5.1 (2025-06-13 ucrt)
* winbuilder: R Under development (unstable) (2025-11-21 r89046 ucrt)

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

## Version 1.1.0

This is a major release, resolving some problems with `plot_discrim()` and adding considerable functionality

* Fixed buglet in `plot_discrim()` where the variables in a formula needed to be reversed.
* `plot_discrim()` now gets the `data` from the object, if not supplied.
* Added `tile.alpha` arg to `plot_discim()`; document how to customize colors, shapes, ...
* `plot_discrim()` gains an `ellipse` argument to draw data ellipses for the groups.
* Added `ellipse.args` to control stat_ellipse() parameters
* Added `labels` and `labels.args` for class labels at group means
* Flesh out package description in README.
* Default for `posterior` in `predict_discrim()` becomes `FALSE`, as rarely needed
* `plot_discrim()` now allows plotting the results in discriminant space, e.g., `LD2 ~ LD1`
* It also generates nice labels for the discriminant dimensions
* Added `scores.lda()` to extract discriminant scores
* Fixed problems in reflect()
* Added examples to README
* Started to add `testthat` to package checks
* Added another vignette using the `MASS::painters` data
* Added `painters2` dataset

