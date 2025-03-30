library(readr)
library(dplyr)

cereal <- read_delim("cereal.csv", delim = ";", 
                     escape_double = FALSE, trim_ws = TRUE)
#View(cereal)
str(cereal)

# missing was coded -1 for missing, in carbo, sugars, potass
cereal <- cereal |>
  mutate(carbo =  ifelse(carbo == -1, NA, carbo),
         sugars = ifelse(sugars == -1, NA, sugars),
         potass = ifelse(potass == -1, NA, potass)
        )

summary(cereal)
# mfr, type should be factors
cereal <- cereal |>
  mutate(mfr = factor(mfr),
         type = factor(type))


save(cereal, file = "cereal.RData")

# ---------------------------------------------

load(here::here("data-raw/cereal", "cereal.RData"))
library(usedata)

use_data(cereal,
   title = "Breakfast Cereal Dataset",
   description = "A multivariate dataset describing seventy-seven commonly available breakfast cereals, based on the information now available on
the F&DA food label.",
   source = "From the 1993 Statistical Graphics Exposition, 'Serial Correlation or Cereal Correlation ??'"
)

# NB: Only works within a package!
# Error in `check_is_package()`:
#   ℹ use_data() is designed to work with packages.
# ✖ Project "cereal" is not an R package.

# Doesn't generate very nice roxygen documentation

# Other sources to be documented in See also
# liver::cereal https://search.r-project.org/CRAN/refmans/liver/html/cereal.html (includes rating)
#     -> cereal-paristech.csv
# taken from: https://perso.telecom-paristech.fr/eagan/class/igr204/datasets
#
# lgrdata::cereals https://search.r-project.org/CRAN/refmans/lgrdata/html/cereals.html
#
# References -- other analses:
#    https://rpubs.com/kss7vs/636466
#    https://www.kaggle.com/code/alejandravillarreal/cereals-nutritional-eda-using-r

# Use my function
source("C:/Dropbox/R/functions/use_data_doc.R")
source_gist("https://gist.github.com/friendly/14f3ee1464213bb0b9fbcb489468383b")
# or edit
usethis::edit_file("C:/Dropbox/R/functions/use_data_doc.R")


# get variable labels from the statlib readme

labeltxt <-
"cereal name [name]
manufacturer (A  G  K  N  P  Q  R) [mfr]
type (cold/hot) [type] 
calories (number) [calories]
protein(g) [protein]
fat(g) [fat]
sodium(mg) [sodium]
dietary fiber(g) [fiber]
complex carbohydrates(g) [carbo]
sugars(g) [sugars]
potassium(mg) [potass] 
vitamins & minerals (0, 25, or 100, respectively indicating 'none added'; 'enriched, often to 25% FDA recommended'; '100% of FDA recommended') [vitamins]
display shelf (1, 2, or 3, counting from the floor) [shelf]
weight (in ounces) of one serving (serving size) [weight]
cups per serving [cups]
health rating of the cereal (unknown calculation method) [rating]
"

labeltxt <- strsplit(labeltxt, "\n") |> unlist()

library(stringr)

labeltxt <- labeltxt|>
  str_replace("(.*) \\[(\\w+)\\]",
              "\\2 = \\1")

# includes the name of the variable in the label itself
use_data_doc(cereal,
             filename = here::here("data-raw/cereal_usedatadoc.R"),
             labels = labeltxt)

# try again
labelmat <- labeltxt |> 
  str_split(" = ", n=2, simplify=TRUE)
colnames(labelmat) <- c("var", "label")

use_data_doc(cereal,
             filename = here::here("data-raw/cereal_usedatadoc2.R"),
             labels = labelmat[,2])
