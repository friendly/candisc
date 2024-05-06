context("pcoa.calc")

imp = read.morphodata("../testFiles/Impatiens_Pektinata.txt")

test_that("correctness of calculation",  {
  pcoa_cmdscale = stats::cmdscale(stats::dist( scale(imp$data, center = TRUE, scale = TRUE)), k = 3, eig = TRUE, x.ret = TRUE)


  pcoaRes = pcoa.calc(imp, distMethod = "euclidean")

  expect_is(pcoaRes, "pcoadata")


  expect_equal(pcoaRes$eigenvalues, pcoa_cmdscale$eig)

  expect_equal(pcoaRes$distMethod, "euclidean")

  expect_equal(paste(round(pcoaRes$objects$scores[1:5,1], digits = 4), collapse = ""), "-2.5844-2.4936-2.6161-2.6956-1.7159")

  expect_equal(paste(round(pcoaRes$groupMeans[1:3,2], digits = 4), collapse = ""), "-2.28772.669NA")


  pcoaRes = pcoa.calc(imp, distMethod = "jaccard")
  expect_equal(pcoaRes$distMethod, "jaccard")





})

