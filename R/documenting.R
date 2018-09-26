#' Create and view R documentation
#'
#' This is a wrapper that uses the [devtools::document()] function to create the
#' documentation, including Rd files, followed by the [Rdpack::viewRd()] function
#' to show the documentation for the specified file.
#' It is intended for use when creating R packages.
#'
#' @param file Name of the Rdfile
#' @param type Defaults to "html"
#' @export
#' @importFrom devtools document
#' @importFrom Rdpack viewRd
#' @examples
#' createandview("my_function_name.Rd")
createandview <- function(filename, type = "html", ...){
  document()
  viewRd(paste0("./man/", filename), type)
}

#TODO: Allow for multiple files given by c("file1", "file2")
