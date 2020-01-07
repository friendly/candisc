## Test environments
* local Windows 7 install, 3.5.3 
* win-builder R Under development (unstable) (2020-01-03 r77629)

## R CMD check results
There were no ERRORs or WARNINGs.  There was one NOTE:

** running examples for arch 'i386' ... [34s] NOTE
Examples with CPU (user + system) or elapsed time > 10s
                user system elapsed
heplot.candisc 24.39   0.11    24.9
** running examples for arch 'x64' ... [13s] OK

This only applies to i386.
I have already made most of the examples \dontrun{}, but would prefer not to reduce the
number of run-able examples further.

## Comments
This is a quite minor release, cleaning up some documentation problems and notes.

