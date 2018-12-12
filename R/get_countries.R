#' Get countries from interinstitutional style guide
#' 
#' Get the list of countries from the Annexes from the Interinstitutional
#' style guide and save countries for use with convert_country.
#' 
#' @export
#' @importFrom XML htmlParse 
#' @examples
#' get_countries()

get_countries <- function(){
  # All countries and codes
  annexA6 <- htmlParse("http://publications.europa.eu/code/en/en-5000600.htm")
  countries <- data.frame(readHTMLTable(getNodeSet(annexA6, "//table")[[1]]))
  names(countries) <- c("ISO2", "full")
  saveRDS(object = countries, file = "../data/countries.rds")
  
  # NUTS regions
  annexA10 <- htmlParse("http://publications.europa.eu/code/en/en-5001000.htm")
  regions <- data.frame(readHTMLTable(getNodeSet(annexA10, "//table")[[1]]))
  regions$ISO2 <- substr(toupper(interinst_regions$Code),
                         start = 1, stop = 2)
  regions <- regions[- which(is.na(regions$Name.in.English)), ]
}