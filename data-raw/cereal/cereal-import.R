library(readr)
cereal <- read_delim("cereal.csv", delim = ";", 
                     escape_double = FALSE, trim_ws = TRUE)
#View(cereal)
str(cereal)

save(cereal, file = "cereal.RData")

load("cereal.RData")
library(usedata)

use_data(cereal,
   title = "Breakfast Cereal Dataset",
   description = "A multivariate dataset describing seventy-seven commonly available breakfast cereals, based on the information now available on
the F&DA food label.",
   source = "From the 1993 Statistical Graphics Exposition, 'Serial Correlation or Cereal Correlation ??'"
)

# Other sources:
# liver::cereal https://search.r-project.org/CRAN/refmans/liver/html/cereal.html
# taken from: https://perso.telecom-paristech.fr/eagan/class/igr204/datasets
#     -> cereal-paristech.csv
