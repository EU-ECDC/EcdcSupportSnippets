library(XML)

# All countries and codes
annexA6 <- htmlParse("http://publications.europa.eu/code/en/en-5000600.htm")
interinst_countries <- data.frame(readHTMLTable(getNodeSet(annexA6, "//table")[[1]]))
names(interinst_countries)[1] <- "ISOalpha2"

# NUTS regions
annexA10 <- htmlParse("http://publications.europa.eu/code/en/en-5001000.htm")
interinst_regions <- data.frame(readHTMLTable(getNodeSet(annexA10, "//table")[[1]]))
interinst_regions$ISOalpha2 <- substr(toupper(interinst_regions$Code),
                                      start = 1, stop = 2)
interinst_regions <- interinst_regions[-which(is.na(interinst_regions$Name.in.English)), ]