# make a dataset of candisc datasets
library(stringr)
library(dplyr)
library(here)
library(tidyr)


concepts <- system2(command = "grep", 
                    args = c(shQuote("concept{"), "man/*.Rd"), 
                    stdout = TRUE)

#  [1] "man/Grass.Rd:\\concept{MANOVA}"      "man/Grass.Rd:\\concept{candisc}"    
#  [3] "man/Grass.Rd:\\concept{discrim}"     "man/HSB.Rd:\\concept{MMRA}"         
#  [5] "man/HSB.Rd:\\concept{cancor}"        "man/PsyAcad.Rd:\\concept{cancor}"   
#  [7] "man/Wine.Rd:\\concept{MANOVA}"       "man/Wine.Rd:\\concept{candisc}"     
#  [9] "man/Wine.Rd:\\concept{discrim}"      "man/Wolves.Rd:\\concept{candisc}"   
# [11] "man/Wolves.Rd:\\concept{discrim}"    "man/cereal.Rd:\\concept{MMRA}"      
# [13] "man/cereal.Rd:\\concept{cancor}"     "man/painters2.Rd:\\concept{MANOVA}" 
# [15] "man/painters2.Rd:\\concept{candisc}" "man/painters2.Rd:\\concept{discrim}"


# Source - https://stackoverflow.com/a/79827844
# Posted by G. Grothendieck, modified by community. See post 'Timeline' for change history
# Retrieved 2025-11-23, License - CC BY-SA 4.0


concepts <- readLines(pipe("grep concept man/*.Rd")) %>%
  grep("concept{", ., fixed = TRUE, value = TRUE) %>% 
  read.table(text = ., sep = "{", comment.char = "}", 
    col.names = c("dataset", "tags")) %>%
  separate(dataset, c(NA, "dataset"), extra = "drop") %>%
  summarize(tags = paste(tags, collapse = " "), .by = dataset) %>%
  arrange(dataset)

#     dataset                   tags
# 1     Grass MANOVA candisc discrim
# 2       HSB            MMRA cancor
# 3   PsyAcad                 cancor
# 4      Wine MANOVA candisc discrim
# 5    Wolves        candisc discrim
# 6    cereal            MMRA cancor
# 7 painters2 MANOVA candisc discrim


dsets <- vcdExtra::datasets("candisc")[, c("Item", "dim", "Title")]     
rowcols <- as.data.frame(stringr::str_split_fixed(dsets$dim,"x", 2))
colnames(rowcols) <- c("rows", "cols")

dsets <- cbind(dsets, rowcols) |>
  rename(dataset = Item) |>
  select(-dim) |>
  relocate(c(rows, cols), .after=dataset) |>
  left_join(concepts, by = "dataset") |>
  print()

#     dataset rows cols                                           Title                   tags
# 1     Grass   40    7 Yields from Nitrogen nutrition of grass species MANOVA candisc discrim
# 2       HSB  600   15                     High School and Beyond Data            MMRA cancor
# 3   PsyAcad  600    8 Psychological Measures and Academic Achievement                 cancor
# 4      Wine  178   14 Chemical composition of three cultivars of wine MANOVA candisc discrim
# 5    Wolves   25   12                                     Wolf skulls        candisc discrim
# 6    cereal   77   16                        Breakfast Cereal Dataset            MMRA cancor
# 7 painters2   54   10     Painters Data with Historical Art Variables MANOVA candisc discrim


write.csv(dsets, 
          file = here::here("extra", "datasets.csv"),
          row.names = FALSE)

# use DT to display

library(here)
library(glue)
library(dplyr)

refurl <- "http://friendly.github.io/candisc/reference/"

dsets <- dsets |>
  mutate(dataset = glue::glue("[{dataset}]({refurl}{dataset}.html)")) 

#knitr::kable(dsets)

library(DT)
DT::datatable(dsets, 
              options = list(pageLength = 15),
              rownames = FALSE,
              filter = "none")
