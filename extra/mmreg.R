# From: http://www.stats.idre.ucla.edu/r/dae/canonical-correlation-analysis

# Example 1. A researcher has collected data on three psychological variables, four academic variables 
# (standardized test scores) and gender for 600 college freshman. 
# She is interested in how the set of psychological variables relates to the academic variables and gender. 
# In particular, the researcher is interested in how many dimensions (canonical variables) are necessary to 
# understand the association between the two sets of variables

library(candisc)
mmreg <- read.csv("https://stats.idre.ucla.edu/stat/data/mmreg.csv")

colnames(mmreg) <- c("Control", "Concept", "Motivation", "Read", "Write", "Math", 
                  "Science", "Sex")
summary(mmreg)

# variable sets
psych <- mmreg[, 1:3]
acad <- mmreg[, 4:8]

mmreg.can <- cancor(cbind(Control, Concept, Motivation) ~ 
                      Read + Write + Math + Science + Sex,
                    data = mmreg)

mmreg.can

redundancy(mmreg.can)

# coef
mmreg.can$coef$X |> round(3)

mmreg.can$coef$Y |> round(3)

# plots

# plot canonical scores
plot(mmreg.can, pch=16, id.n = 3)
text(-2, 3, paste("Can R =", round(mmreg.can$cancor[1], 3)), pos = 3)

plot(mmreg.can, which = 2, pch=16, id.n = 3)
text(-2, 3.5, paste("Can R =", round(mmreg.can$cancor[2], 3)), pos = 3)


