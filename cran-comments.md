## Test environments
* local Windows 7 install, 3.2.5 (2016-04-14)
* R-Forge R version 3.3.2 Patched (2016-11-07 r71637)
* win-builder R Under development (unstable) (2016-11-09 r71639)

## R CMD check results
There were no ERRORs or WARNINGs.  There was one NOTE:

** running examples for arch 'i386' ... [32s] NOTE
Examples with CPU or elapsed time > 10s
                user system elapsed
heplot.candisc 18.25   0.11   18.89

I have already made several examples \dontrun{}, but would prefer not to reduce the
number of run-able examples further.

## Comments
This is a minor release, fixing a serious bug and adding some enhancements

### candisc 0.7-2

  o Add Wilks.candisc method;  this corrects a bug where the values of the stepdown tests for canonical discriminant analysis were calculated incorrectly [thx: Martina Vandebroek]
  o Now use Wilks.candisc in print.candisc

### candisc 0.7-1

  o respect var.lwd in 2D plot.candisc()
  o heplot.candisc() gets a rev.axes argument to reverse the axes and a var.pos argument to position  variable labels
  o vectors() now produces nicer arrow head a la matlib::vectors()
  o added var.pos argument to plot.candisc
  o allow to suppress likelihood ratio tests in print.candisc
  
