Sys.setenv(RGL_USE_NULL = TRUE)

# get list of possibly misspelled words
wds <- spelling::spell_check_package()
cat(paste(wds[, "word"], collapse = "\n"))
# to add all words
update_wordlist()

# check reverse dependencies
devtools::revdep()
# [1] "Guerry"               "heplots"              "KnowBR"               "MorphoTools2"        
# [5] "MultivariateAnalysis" "smacof"               "SurveyCC"

# revdep
#remotes::install_github("r-lib/revdepcheck")
#library(revdepcheck)
revdepcheck::revdep_check(num_workers = 4)


library(devtools)

# prepare pkgdown site
build_readme()
pkgdown::build_site()

devtools::build()
devtools::build_vignettes()

devtools::check_win_devel()
