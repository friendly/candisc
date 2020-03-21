## Test environments
* local Windows 7 install, 3.6.2 (2019-12-12) 
* win-builder R Under development (unstable) (2020-03-11 r77925)

## R CMD check results
There were no ERRORs or WARNINGs.  There was one NOTE:, only under Windows 32-bit

** running examples for arch 'i386' ... [32s] NOTE
Examples with CPU (user + system) or elapsed time > 10s
                user system elapsed
heplot.candisc 23.46   0.22   23.79
** running examples for arch 'x64' ... [10s] OK

This only applies to i386.
I have already made most of the examples \donttest{}, but would prefer not to reduce the
number of run-able examples further.

## Comments
This is a minor release, cleaning up some documentation problems and notes. Also testing
under 3.6.2 revealed a glitch in the vignette, now fixed.

