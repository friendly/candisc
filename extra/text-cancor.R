# cancor tests

data(PsyAcad, package = "candisc")

PsyAcad$Sex <- as.numeric(PsyAcad$Sex)
PsyAcad.can <- cancor(cbind(LocControl, SelfConcept, Motivation) ~ 
                        Read + Write + Math + Science + Sex,
                      data = PsyAcad)

PsyAcad.can

PsyAcad.can$structure[[1]]

## compare with stats::cancor


## compare with CCA::
library(CCA)

psych <- PsyAcad[, 1:3]
acad <- PsyAcad[, 4:8]

cc1 <- cc(psych, acad)
cc2 <- comput(psych, acad, cc1)

cc2[[3]]
cc2[[6]]

