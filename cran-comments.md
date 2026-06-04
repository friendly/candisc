## Test environments
* local Windows 11, 4.5.2 (2025-10-31 ucrt)
* winbuilder: R Under development (unstable) (2026-06-03 r90099 ucrt)

## R CMD check results
There were no ERRORs, WARNINGs or NOTES 

## reverse dependencies

`revdepcheck::revdep_check()` failed to run due to a bug in one of its
dependencies (`mime` not exported by `namespace:gmailr`).

`devtools::revdep()` lists 6 packages, but Guerry, heplots, and KnowBR only
list candisc in `Suggests` and are not affected by changes to the package API.
The 3 packages that `Depend` on or `Import` candisc are:
MorphoTools2, MultivariateAnalysis, SurveyCC.

These were checked manually using `rcmdcheck` and no new problems were found.

## Comments

## Version 1.1.1

This is a minor release, making heplots more flexible

* `heplot.cancor()` gains a `rev.axes` argument, similar to that in `heplot.candisc()`
* `rev.axes` also added to `heplot3d*()` functions
* Added `confusion()` to calculate confusion matrices for LDA/QDA

