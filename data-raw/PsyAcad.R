# From: http://www.stats.idre.ucla.edu/r/dae/canonical-correlation-analysis

# A researcher has collected data on three psychological variables, four academic variables 
# (standardized test scores) and gender for 600 college freshman. 
# She is interested in how the set of psychological variables relates to the academic variables and gender. 
# In particular, the researcher is interested in how many dimensions (canonical variables) are necessary to 
# understand the association between the two sets of variables

PsyAcad <- read.csv("https://stats.idre.ucla.edu/stat/data/mmreg.csv")

colnames(PsyAcad) <- c("LocControl", "SelfConcept", "Motivation", "Read", "Write", "Math", 
                       "Science", "Sex")
PsyAcad$Sex <- factor(PsyAcad$Sex, labels = c("M", "F"))
str(PsyAcad)

save(PsyAcad, file = here::here("data-raw", "PsyAcad.RData"))

use_data_doc(PsyAcad, 
             title = "Psychological Measures and Academic Achievement",
             filename = here::here("data-raw", "PsyAcad-doc.R"))