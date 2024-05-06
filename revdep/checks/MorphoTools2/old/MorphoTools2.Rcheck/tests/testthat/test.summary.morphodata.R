context("summary.morphodata")


test_that("correct info about class structure", {
  data = read.morphodata("../testFiles/sample.txt")
  output = capture.output(summary(data))

    expect_equal(output[1], "Object of class 'morphodata'")
  expect_equal(output[2], " - contains 33 populations")
  expect_equal(output[5], "Populations: BABL, BABU, BOL, BRT, BUK, CERM, CERV, CZLE, DEB, DOM, DUB, HVLT, KASH, KOT, KOZH, KRO, LES, LIP, MIL, NEJ, NSED, OLE1, OLE2, PREL, PRIS, PROS, RTE, RUS, SOK, STCV, STGH, VIT, VOL")
})




