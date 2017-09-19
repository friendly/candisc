## Test environments
* local Windows 7 install, 3.4.1 (2017-06-30)
* R-Forge R 3.3.3 Patched (2017-03-15 r72357)
* win-builder R Under development (unstable) (2017-09-12 r73242)

## R CMD check results
There were no ERRORs or WARNINGs.  There was one NOTE:

** running examples for arch 'i386' ... [32s] NOTE
Examples with CPU or elapsed time > 10s
                user system elapsed
heplot.candisc 18.25   0.11   18.89

I have already made most of the examples \dontrun{}, but would prefer not to reduce the
number of run-able examples further.

## Comments
This is a semi-major release, adding some enhancements and a new vignette.
The package development was migrated from F-Forge to github.

### Changes in version 0.8-0 (2017-09-15)

o Fix 1D plot.candisc to better reflect the canonical structure coefficients. The ylim of the
  scale is now forced to include 0 and -1 and/or +1 depending on the signs of the structure
  coefficients.  [thx: Martina Vandebroek]
o Pass ... to boxplot() and plot() for 1D in plot.candisc
o Added diabetes vignette

### candisc 0.7-2

  o Add Wilks.candisc method;  this corrects a bug where the values of the stepdown tests for canonical discriminant analysis were calculated incorrectly [thx: Martina Vandebroek]
  o Now use Wilks.candisc in print.candisc


