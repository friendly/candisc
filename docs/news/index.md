# Changelog

## Version 1.1.0

This is a major release, resolving some problems with
[`plot_discrim()`](https://friendly.github.io/candisc/reference/plot_discrim.md)
and adding considerable functionality

- Fixed buglet in
  [`plot_discrim()`](https://friendly.github.io/candisc/reference/plot_discrim.md)
  where the variables in a formula needed to be reversed.
- [`plot_discrim()`](https://friendly.github.io/candisc/reference/plot_discrim.md)
  now gets the `data` from the object, if not supplied.
- Added `tile.alpha` arg to `plot_discim()`; document how to customize
  colors, shapes, …
- [`plot_discrim()`](https://friendly.github.io/candisc/reference/plot_discrim.md)
  gains an `ellipse` argument to draw data ellipses for the groups.
- Added `ellipse.args` to control stat_ellipse() parameters
- Added `labels` and `labels.args` for class labels at group means
- Flesh out package description in README.
- Default for `posterior` in
  [`predict_discrim()`](https://friendly.github.io/candisc/reference/predict_discrim.md)
  becomes `FALSE`, as rarely needed
- [`plot_discrim()`](https://friendly.github.io/candisc/reference/plot_discrim.md)
  now allows plotting the results in discriminant space, e.g.,
  `LD2 ~ LD1`
- It also generates nice labels for the discriminant dimensions
- Added
  [`scores.lda()`](https://friendly.github.io/candisc/reference/scores.lda.md)
  to extract discriminant scores
- Fixed problems in reflect()
- Added examples to README
- Started to add `testthat` to package checks
- Added another vignette using the
  [`MASS::painters`](https://rdrr.io/pkg/MASS/man/painters.html) data

## Version 1.0.0

CRAN release: 2025-11-05

This is a major release, adding methods for linear/quadratic
discriminant analysis and improving package documentation

- Added
  [`predict_discrim()`](https://friendly.github.io/candisc/reference/predict_discrim.md)
  as a wrapper to
  [`MASS::predict.lda()`](https://rdrr.io/pkg/MASS/man/predict.lda.html)
  returning a data.frame
- Added
  [`plot_discrim()`](https://friendly.github.io/candisc/reference/plot_discrim.md)
  to plot decision regions for discriminant analysis using contours or
  background tiles
- Added
  [`cor_lda()`](https://friendly.github.io/candisc/reference/cor_lda.md)
  to calculate structure correlations between variables and discriminant
  scores
- Added
  [`scores.lda()`](https://friendly.github.io/candisc/reference/scores.lda.md)
  method to extract discriminant scores
- Added
  [`reflect()`](https://friendly.github.io/candisc/reference/reflect.md)
  generic to allow axis reversal for candisc and cancor objects
- Improved documentation of a number of functions
- Added additional plots to dataset documentation
- Now use `Roxygen: list(markdown = TRUE)` in DESCRIPTION
- Ran `roxygen2md(scope = "simple")` for first pass of roxygen
  conversion to markdown, others converted by hand

## Version 0.9.2

o correct buglet with `var.labels` in `heplot.candisc` o Added cereal
data

## Version 0.9.1

- [`heplot.candisc()`](https://friendly.github.io/candisc/reference/heplot.candisc.md)
  gains a `var.labels` argument
- add extra/mmreg.R example
- add
  [`scores.candisc()`](https://friendly.github.io/candisc/reference/candisc.md)
  method to extract canonical discriminant scores
- added `cereal` dataset
- added `PsyAcad` dataset

## Version 0.9.0 (2024-05-05)

CRAN release: 2024-05-06

This is a semi-major release, largely of the documentation of the
package.

- Created `pkgdown` site, <https://friendly.github.io/candisc/>
- Convert documentation to roxygen
- Extend description of candisc/cancor methods
- Added `diabetes` vignette giving more discursive examples

## Version 0.8-6 (2021-10-06)

CRAN release: 2021-10-07

- Fix JSS URLs -\> DOI

## Version 0.8-5 (2020-12-15)

CRAN release: 2021-01-22

- Fix CRAN nits re conditional use of rgl in examples

## Version 0.8-4 (2020-05-06)

- add points.1d option to plot.candisc for 1D case

## Version 0.8-3 (2020-04-20)

CRAN release: 2020-04-22

o dontrun/donttest more examples from heplot.candisc to appease the CRAN
daemon.

## Version 0.8-2 (2020-01-06)

o Clarify docs for plot.candisc wrt col & pch (thx: Mohammad Bahram) o
candisc gets a hex sticker on GitHub o Fix notes from
devtools::check_win_devel

## Version 0.8-1 (2017-10-05)

o Fixed bug in plot.candisc with default col and pch values (thx: David
Carlson)

## Version 0.8-0 (2017-09-16)

CRAN release: 2017-09-19

o Fix 1D plot.candisc to better reflect the canonical structure
coefficients. The ylim of the scale is now forced to include 0 and -1
and/or +1 depending on the signs of the structure coefficients. \[thx:
Martina Vandebroek\] o Pass … to boxplot() and plot() for 1D in
plot.candisc o Added diabetes vignette

## Version 0.7-2 (2016-11-09)

CRAN release: 2016-11-11

o Add Wilks.candisc method; this corrects a bug where the values of the
stepdown tests for canonical discriminant analysis were calculated
incorrectly \[thx: Martina Vandebroek\] o Now use Wilks.candisc in
print.candisc

## Version 0.7-1 (2016-05-23)

o respect var.lwd in 2D plot.candisc() o heplot.candisc() gets a
rev.axes argument to reverse the axes and a var.pos argument to position
variable labels o vectors() now produces nicer arrow head a la
matlib::vectors() o added var.pos argument to plot.candisc o allow to
suppress likelihood ratio tests in print.candisc

## Version 0.7-0 (2016-04-25)

CRAN release: 2016-04-27

o Added Wine data – three cultivars with a very simple canonical
structure o Added ellipses to plot.candisc(); enhanced candisc.Rd
documentation o Added varOrder() for effect ordering in MLMs o
plot.candisc() gets a var.labels argument o added method=“colmean” and
descending=T/F to varOrder() o plot.candisc() gets a rev.axes argument o
fixed imports() in NAMESPACE for CRAN checks

## Version 0.6-7 (2015-04-15)

CRAN release: 2015-04-19

o Now use rgl:: in \*3d functions and requireNamespace(“rgl”) o
import(car)

## Version 0.6-6 (2013-06-17)

``` R
o Added vecscale() to more reliably scale the variable vectors in plot.candisc() and heplot.candisc()
  to the plot bounding box [thx: Uwe Ligges for the code]
o Exported vecscale
o Added can_lm() to calculate the canonical lm() representation of a term in an mlm
```

## Version 0.6-5 (2013-03-20)

CRAN release: 2013-06-12

``` R
o candisc() now doesn't allow ndim > rank [thx: yu-chuan.chen@stonybrook.edu]
o In plot.candisc() fixed bug in use of pch and col [thx: dcarlson@tamu.edu] and cleaned up code
```

## Version 0.6-4 (2013-03-17)

``` R
o Don't use paste0() to avoid dependency on R>2.15.0
```

## Version 0.6-3 (2013-02-13)

CRAN release: 2013-03-15

``` R
o Minor documentation changes
o In cancor(), now handle missing data more flexibly via na.rm= and use=
o Now suggest corrplot package for cancor.Rd example
```

## Version 0.6-2 (2013-01-30)

CRAN release: 2013-02-12

``` R
o Reorganized print() and summary() methods for cancor()
o Smoothed out documentation
o Added observation weights to cancor() methods
o Added ability to plot X and or Y vectors in heplot.cancor()
o Extended example of plot.cancor(), showing variable vectors for X & Y
```

## Version 0.6-1 (2013-1-23)

CRAN release: 2013-01-30

``` R
o Continued development of methods and plots for canonical correlation analysis within the
  HE plot framework:
o Now export scores() and scores.cancor() method
o coef.cancor gets a standardize= argument
o Added redundancy() for redundancy analysis
o Added a plot.cancor() method, visualizing the relations between the Ycan and Xcan variable scores
o Added vectors3d()
o Added heplot3d() method for cancor objects.
o More significantly, re-implemented cancor() as an S3 generic, with a cancor.formula method and 
  the original as the cancor.default method.
```

## Version 0.6-0 (2013-1-20)

CRAN release: 2013-01-23

``` R
o Added cancor and related methods for canonical correlation analysis
o Added Wilks() methods for Wilks' Lambda canonical tests
o Added vectors() for drawing labeled vectors
o Added S3 heplot.cancor() method for cancor objects.
```

## Version 0.5-23 (2012-2-3)

``` R
o Fixed buglet in summary.candisc() [thx: David Carlson, dcarlson@tamu.edu]
o heplot.candisc now uses plot.candisc in the 1 df case
```

## Version 0.5-22 (2011-12-10)

``` R
o Extended Description:
```

## Version 0.5-21 (2011-09-12)

CRAN release: 2011-12-11

``` R
o Fixed Authors@R in DESCRIPTION for R 2.14.x
```

## Version 0.5-20 (2010-10-208)

``` R
o Updated links to datavis.ca
o Updated candisc heplot3d() examples
```

## Version 0.5-19 (2010-7-29)

CRAN release: 2010-09-19

``` R
 o switched inst/CHANGES to NEWS
 o Extended candiscList and Grass examples
 o Extended package description
 o Fixed minor buglet in print.candisc
```

## Version 0.5-18 (2010-7-27)

CRAN release: 2010-07-29

``` R
o  Fixed predictor.names problem with car_2.0-0
o  Added var.cex to heplot.candisc and heplot3d.candisc
```

## Version 0.5-17 (2010-2-11)

``` R
o  Allow to select canonical dimension in plot(candisc(), which=)
```

## Version 0.5-15 (2009-6-12)

CRAN release: 2009-06-14

``` R
o  Added titles.1d argument to plot.candisc to allow customized titles for 1D plots
   (wish of Manuel Sp?nola)
```

## Version 0.5-13 (2008-12-16)

CRAN release: 2009-02-02

``` R
o  Added Wolves data, with examples for 2-way design.
o  Improved plot for 1D case.
```

## Version 0.5-11 (2008-11-12)

``` R
o  Michael Friendly now maintainer
o  now require heplots >= 0.8-3 for use of xlim, ylim, zlim
o  added asp="iso" to heplot3d.candisc, so default is now equal scaling
```

## Version 0.5-10 (2008-11-5)

CRAN release: 2008-11-09

``` R
o  improved documentation
o  added var.lwd to heplot3d.candisc
o  changed rgl.* to *3d functions to avoid rgl problems
o  added suffix= to heplot.candisc and heplot3d.candisc
o  added graphics=TRUE to menus in *.candiscList functions
o  added suffix= to plot.candisc
```

## Version 0.5-9 (2008-04-24)

CRAN release: 2008-04-14

## Version 0.5-8 (2008-04-11)

## Version 0.5-7 (2007-10-29)

``` R
o Initial version released to CRAN.
```
