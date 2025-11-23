# make a dataset of candisc datasets
library(stringr)
library(dplyr)
library(here)


#concepts <- system2('grep  "concept{" man/*.Rd', stdout = TRUE)
concepts <- system2(command = "grep", 
                    args = c(shQuote("concept{"), "man/*.Rd"), 
                    stdout = TRUE)
concepts |>
  str_replace("man/", "") |>
  str_replace(".Rd", "") |>
  str_replace("concept\\{", "")

# Source - https://stackoverflow.com/a/79827659
# Posted by user2554330
# Retrieved 2025-11-22, License - CC BY-SA 4.0

filename <- "man/painters2.Rd"
rd <- tools::parse_Rd(filename)
for (i in seq_along(rd))
  if (attr(rd[[i]], "Rd_tag") == "\\concept")
    print(filename, " has the concept ", rd[[i]])


dsets <- vcdExtra::datasets("candisc")[, c("Item", "dim", "Title")]
rowcols <- as.data.frame(stringr::str_split_fixed(dsets$dim,"x", 2))
colnames(rowcols) <- c("rows", "cols")

dsets.table <- cbind("dataset" = dsets$Item, rowcols, "title" =dsets$Title)
head(dsets.table)

write.csv(dsets.table, file = here::here("extra", "datasets.csv"))

# use DT to display

library(here)
library(glue)
library(dplyr)
dsets <- read.csv(here::here("extra", "datasets.csv"))
dsets <- dsets[,-1]  # remove row number

refurl <- "http://friendly.github.io/candisc/reference/"

dsets <- dsets |>
  mutate(dataset = glue::glue("[{dataset}]({refurl}{dataset}.html)")) 

#knitr::kable(dsets)

library(DT)
DT::datatable(dsets, 
              options = list(pageLength = 15),
              rownames = FALSE,
              filter = "none")
