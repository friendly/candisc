## Version 1.1.0

This is a minor release, resolving some problems with `plot_discrim()` and adding considerable functionality

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


## Version 0.9.2

o correct buglet with `var.labels` in `heplot.candisc`
o Added cereal data

## Version 0.9.1

* `heplot.candisc()` gains a `var.labels` argument
* add extra/mmreg.R example
* add `scores.candisc()` method to extract canonical discriminant scores
* added `cereal` dataset
* added `PsyAcad` dataset

## Version 0.9.0 (2024-05-05)

This is a semi-major release, largely of the documentation of the package.

* Created `pkgdown` site, https://friendly.github.io/candisc/
* Convert documentation to roxygen
* Extend description of candisc/cancor methods
* Added `diabetes` vignette giving more discursive examples 

## Version 0.8-6 (2021-10-06)

* Fix JSS URLs -> DOI

## Version 0.8-5 (2020-12-15)

* Fix CRAN nits re conditional use of rgl in examples

## Version 0.8-4 (2020-05-06)

* add points.1d option to plot.candisc for 1D case

## Version 0.8-3 (2020-04-20)

o dontrun/donttest more examples from heplot.candisc to appease the CRAN daemon.

## Version 0.8-2 (2020-01-06)

o Clarify docs for plot.candisc wrt col & pch (thx: Mohammad Bahram)
o candisc gets a hex sticker on GitHub
o Fix notes from devtools::check_win_devel

## Version 0.8-1 (2017-10-05)

o Fixed bug in plot.candisc with default col and pch values (thx: David Carlson)

## Version 0.8-0 (2017-09-16)

o Fix 1D plot.candisc to better reflect the canonical structure coefficients. The ylim of the
  scale is now forced to include 0 and -1 and/or +1 depending on the signs of the structure
  coefficients.  [thx: Martina Vandebroek]
o Pass ... to boxplot() and plot() for 1D in plot.candisc
o Added diabetes vignette

## Version 0.7-2 (2016-11-09)

  o Add Wilks.candisc method;  this corrects a bug where the values of the stepdown tests for canonical discriminant analysis were calculated incorrectly [thx: Martina Vandebroek]
  o Now use Wilks.candisc in print.candisc

## Version 0.7-1 (2016-05-23)

  o respect var.lwd in 2D plot.candisc()
  o heplot.candisc() gets a rev.axes argument to reverse the axes and a var.pos argument to position  variable labels
  o vectors() now produces nicer arrow head a la matlib::vectors()
  o added var.pos argument to plot.candisc
  o allow to suppress likelihood ratio tests in print.candisc
  

## Version 0.7-0 (2016-04-25)

  o Added Wine data -- three cultivars with a very simple canonical structure
  o Added ellipses to plot.candisc(); enhanced candisc.Rd documentation
  o Added varOrder() for effect ordering in MLMs
  o plot.candisc() gets a var.labels argument
  o added method="colmean" and descending=T/F to varOrder()
  o plot.candisc() gets a rev.axes argument
  o fixed imports() in NAMESPACE for CRAN checks

## Version 0.6-7 (2015-04-15)

  o Now use rgl:: in *3d functions and requireNamespace("rgl")
  o import(car)

## Version 0.6-6 (2013-06-17)

	o Added vecscale() to more reliably scale the variable vectors in plot.candisc() and heplot.candisc()
	  to the plot bounding box [thx: Uwe Ligges for the code]
	o Exported vecscale
	o Added can_lm() to calculate the canonical lm() representation of a term in an mlm

## Version 0.6-5 (2013-03-20)

	o candisc() now doesn't allow ndim > rank [thx: yu-chuan.chen@stonybrook.edu]
	o In plot.candisc() fixed bug in use of pch and col [thx: dcarlson@tamu.edu] and cleaned up code

## Version 0.6-4 (2013-03-17)

	o Don't use paste0() to avoid dependency on R>2.15.0

## Version 0.6-3 (2013-02-13)

	o Minor documentation changes
	o In cancor(), now handle missing data more flexibly via na.rm= and use=
	o Now suggest corrplot package for cancor.Rd example

## Version 0.6-2 (2013-01-30)

	o Reorganized print() and summary() methods for cancor()
	o Smoothed out documentation
	o Added observation weights to cancor() methods
	o Added ability to plot X and or Y vectors in heplot.cancor()
	o Extended example of plot.cancor(), showing variable vectors for X & Y
	
## Version 0.6-1 (2013-1-23)

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

## Version 0.6-0 (2013-1-20)

	o Added cancor and related methods for canonical correlation analysis
	o Added Wilks() methods for Wilks' Lambda canonical tests
	o Added vectors() for drawing labeled vectors
	o Added S3 heplot.cancor() method for cancor objects.

## Version 0.5-23 (2012-2-3)

	o Fixed buglet in summary.candisc() [thx: David Carlson, dcarlson@tamu.edu]
	o heplot.candisc now uses plot.candisc in the 1 df case

## Version 0.5-22 (2011-12-10)

	o Extended Description:

## Version 0.5-21 (2011-09-12)

	o Fixed Authors@R in DESCRIPTION for R 2.14.x

## Version 0.5-20 (2010-10-208)

	o Updated links to datavis.ca
	o Updated candisc heplot3d() examples

## Version 0.5-19 (2010-7-29)

	 o switched inst/CHANGES to NEWS
	 o Extended candiscList and Grass examples
	 o Extended package description
	 o Fixed minor buglet in print.candisc

## Version 0.5-18 (2010-7-27)

	o  Fixed predictor.names problem with car_2.0-0
	o  Added var.cex to heplot.candisc and heplot3d.candisc

## Version 0.5-17 (2010-2-11)

	o  Allow to select canonical dimension in plot(candisc(), which=)

## Version 0.5-15 (2009-6-12)

	o  Added titles.1d argument to plot.candisc to allow customized titles for 1D plots
	   (wish of Manuel Sp?nola)

## Version 0.5-13 (2008-12-16)

	o  Added Wolves data, with examples for 2-way design.
	o  Improved plot for 1D case.

## Version 0.5-11 (2008-11-12)

	o  Michael Friendly now maintainer
	o  now require heplots >= 0.8-3 for use of xlim, ylim, zlim
	o  added asp="iso" to heplot3d.candisc, so default is now equal scaling

## Version 0.5-10 (2008-11-5)

	o  improved documentation
	o  added var.lwd to heplot3d.candisc
	o  changed rgl.* to *3d functions to avoid rgl problems
	o  added suffix= to heplot.candisc and heplot3d.candisc
	o  added graphics=TRUE to menus in *.candiscList functions
	o  added suffix= to plot.candisc

## Version 0.5-9 (2008-04-24)

## Version 0.5-8 (2008-04-11)

## Version 0.5-7 (2007-10-29)

	o Initial version released to CRAN.








