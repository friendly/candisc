context("calcDistance")



morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "Ch1" = c(1:8),
                             "Ch2" = 11:18,
                             "Ch3" = c(22, 21, 23, 3, 44, 1, 8, 8 ),
                             "Ch4" = rep(1, 8))


morphoDataFrame_bin = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                             "Ch1" = c(1, 0, 0, 1, 0, 0, 1, 0),
                             "Ch2" = c(0, 1, 0, 1, 0, 1, 1, 1),
                             "Ch3" = c(0, 0, 1, 0, 0, 0, 0, 1),
                             "Ch4" = rep(1, 8))


morphoMockup = .morphodataFromDataFrame(morphoDataFrame)
morphoMockup.bin = .morphodataFromDataFrame(morphoDataFrame_bin)

gowerMockup = list(
  ID = as.factor(c("id1","id2","id3","id4","id5","id6")),
  Population = as.factor(c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3")),
  Taxon = as.factor(c("TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB")),
  data = data.frame(
    stemBranching = c(1, 1, 1, 0, 0, 0),   # binaryChs
    petalColour = c(1, 1, 2, 3, 3, 3),     # nominalChs; 1=white, 2=red, 3=blue
    leaves = c(1, 1, 1, 2, 2, 3),          # nominalChs; 1=simple, 2=palmately compound, 3=pinnately compound
    taste = c(2, 2, 2, 3, 1, 1),           # ordinal; 1=hot, 2=hotter, 3=hottest
    stemHeight = c(10, 11, 14, 22, 23, 21),         # quantitative
    leafLength = c(8, 7.1, 9.4, 1.2, 2.3, 2.1)  )   # quantitative
)
attr(gowerMockup, "class") <- "morphodata"


test_that("correct info about class structure", {


  d1 = .calcDistance(morphoMockup, distMethod = "euclidean", scale = T, center = T)
  expect_equal(paste(d1[1:5], collapse = ","), "0.671593708886502,1.33580366938756,2.52592818565872,3.20974222499387,3.74418449597971")
  expect_equal(paste(d1[12:17], collapse = ","), "3.49648974814622,4.13694687514603,1.75553712379927,2.16462103071219,2.6816662804677,2.931669459488")

  d2 = .calcDistance(morphoMockup, distMethod = "jaccard", scale = T, center = T)
  expect_equal(paste(d2[1:5], collapse = ","), "0,0,0,0,0")

  d3 = .calcDistance(morphoMockup, distMethod = "simpleMatching", scale = T, center = T)
  expect_equal(paste(d3[15:25], collapse = ","), "0,0,0,0,0,0,0,0,0,0,0")

  expect_error( .calcDistance(morphoMockup, distMethod = "ee"), "distMethod \"ee\" is not supported.")

  d1.bin = .calcDistance(morphoMockup.bin, distMethod = "euclidean", scale = T, center = T)
  expect_equal(paste(d1.bin[1:5], collapse = ","), "3.15524255098646,3.3466401061363,2.23109340409087,2.23109340409087,3.15524255098646")

  d2.bin = .calcDistance(morphoMockup.bin, distMethod = "jaccard", scale = T, center = T)
  expect_equal(paste(d2.bin[1:5], collapse = ","), "0.816496580927726,0.816496580927726,0.577350269189626,0.707106781186548,0.816496580927726")

  d3.bin = .calcDistance(morphoMockup.bin, distMethod = "simpleMatching", scale = T, center = T)
  expect_equal(paste(d3.bin[15:25], collapse = ","), "0.5,0.707106781186548,0.866025403784439,0.5,0.707106781186548,0.5,0,0.707106781186548,0.5,0.707106781186548,0.707106781186548")

  # gower


  g1 = .calcDistance(gowerMockup, distMethod = "gower", binaryChs = c("stemBranching"), nominalChs = c("petalColour", "leaves"), ordinalChs = c("taste"))
  expect_equal(paste(g1[1:5], collapse = ","), "0.0311131957473421,0.246404002501563,0.875390869293308,0.865853658536585,0.844277673545966")
  expect_equal(paste(g1[12:17], collapse = ","), "0.82145090681676,0.242213883677298,0.437335834896811,0.235647279549719,NA,NA")

})



