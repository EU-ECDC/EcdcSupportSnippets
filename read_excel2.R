# Wrapper for here and readxl that takes location from current folder of file
# if here() does not point to that location and loads xlsx-file 
# (name of file is provided as a string, e.g. "exmpl.xlsx")
# Requires use of RStudio

library(here)
library(readxl)

# Load data
read_excel2 <- function(xlsx_file){
  loc <- stringr::str_split(rstudioapi::getSourceEditorContext()$path, "/")[[1]]
  loc <- loc[- length(loc)]
  loc <- paste(loc, collapse = "/")
  if(here() != loc){
    print("'here' is pointing in the wrong direction, manual link inserted")
    data <- read_excel(paste0(loc, xlsx_file))
    } else {
      data <- read_excel(here(xlsx_file))
    }
}
