## Test environments
* local Windows 10, R version 4.3.2 (2023-10-31 ucrt)
* R Under development (unstable) (2024-05-04 r86521 ucrt)

## R CMD check results
There were no ERRORs, WARNINGs or NOTES 

## reverse dependencies

> devtools::revdep()
[1] "Guerry"               "heplots"              "KnowBR"               "MorphoTools2"        
[5] "MultivariateAnalysis" "smacof"               "SurveyCC"  

### revdepcheck results

> Sys.setenv(R_BIOC_VERSION = 3.18)
> revdepcheck::revdep_check(num_workers = 4)

We checked 7 reverse dependencies, comparing R CMD check results across CRAN and dev versions of this package.

 * We saw 0 new problems
 * We failed to check 0 packages


## Comments

### Version 0.9.0 (2024-05-05)

This is a semi-major release, largely of the documentation of the package.

* Created `pkgdown` site, https://friendly.github.io/candisc/
* Convert documentation to roxygen
* Extend description of candisc/cancor methods
* Added `diabetes` vignette giving more discursive examples 



