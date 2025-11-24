context("populOTU")

morphoDataFrame = data.frame("ID" = c("id1","id2","id3","id4","id5","id6","id7","id8"),
                             "Population" = c("Pop1", "Pop1", "Pop2", "Pop2", "Pop3", "Pop3", "Pop4", "Pop4"),
                             "Taxon" = c("TaxA", "TaxA", "TaxA", "TaxA", "TaxB", "TaxB", "TaxB", "TaxB"),
                               "Ch1" = 1:8,
                               "Ch2" = 11:18)

morphoMockup = .morphodataFromDataFrame(morphoDataFrame)


test_that("correct calculations",  {

    pop = populOTU(morphoMockup)

    expect_equal(levels(pop$ID) , levels(pop$Population))

    expect_equal(pop$data[1,1], ((1+2)/2))
    expect_equal(pop$data[1,2], ((11+12)/2))

    expect_equal(pop$data[4,1], ((7+8)/2))
    expect_equal(pop$data[4,2], ((17+18)/2))

    expect_is(morphoMockup, "morphodata")
})

