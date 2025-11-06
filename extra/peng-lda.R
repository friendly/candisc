library(MASS)
data(peng, package="heplots")
source(here::here("C:/R/Projects/Vis-MLM-book/R/penguin/penguin-colors.R"))

peng.lda <- lda(species ~ bill_length + bill_depth + flipper_length + body_mass, 
                data = peng)


plot_discrim(peng.lda, bill_depth ~ bill_length,
             data = peng) +
    theme_penguins() 
