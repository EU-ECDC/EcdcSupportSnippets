#' Convert country names
#'
#' This is a function allowing for the conversion of country names from one
#' format to another. It uses the list of 31 EU/EEA countries.
#'
#' @param name Country name to be converted
#' @param type Can take the values "full", "ISO2", and "ISO3"
#' @export
#'
convert_country <- function(name, type, ...){
  if(!(type %in% c("full", "ISO2", "ISO3")))
    stop("incorrect type argument")
  if(type == "ISO2" && length(name) == 2)
    stop("name input incorrect length for conversion to ISO alpha 2 format")
  if(type == "ISO2" && length(name) == 3)
    stop("name input incorrect length for conversion to ISO alpha 3 format")
  # Load reference countries dataset
  #data("countries", package = ECDCpkg, envir = environment())
  data("countries", package = character(0), envir = environment())
  if(!(name %in% c(levels(countries[, 1]),
                   levels(countries[, 2]),
                   levels(countries[, 3]))))
    stop("name input not recognised")

  # Full name given
  if(name %in% countries[, 1])
    if(type == "ISO2")
      out <- countries[which(countries[, 1] == name), 2]
    if(type == "ISO3")
      out <- countries[which(countries[, 1] == name), 3]
  # ISO alpha 2 name given
  if(name %in% countries[, 2])
    if(type == "full")
      out <- countries[which(countries[, 2] == name), 1]
    if(type == "ISO3")
      out <- countries[which(countries[, 2] == name), 3]

  # ISO alpha 3 name given
  if(name %in% countries[, 3])
    if(type == "full")
      out <- countries[which(countries[, 3] == name), 1]
    if(type == "ISO2")
      out <- countries[which(countries[, 3] == name), 2]

    return(out)
}

#TODO: Make inputs and first column of countries uppercase so user input errors
# avoided
