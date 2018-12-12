#' Get both data set and information on it
#' 
#' This is a wrapper for the Eurostat package which retrieves both the data and
#' information about that data and returns it as a list
#' 
#' @param dataset code of Eurostat dataset to retrieve
#' @export
#' @importFrom eurostat get_eurostat search_eurostat
#' @import dplyr 
eurostat_dataset_and_info <- function(dataset = "aact_ali01", ...){
  out <- list()
  out$data <- get_eurostat(id = dataset)
  out$info <- search_eurostat("*", fixed = FALSE) %>% 
    filter(code == dataset)
  return(out)
}

#' List all the available datasets
#' 
#' This is a wrapper for the Eurostat package which prints a list of the entire
#' list of available data sets
#' 
#' @param dataset code of Eurostat dataset to retrieve
#' @export
#' @importFrom eurostat get_eurostat search_eurostat
#' @import dplyr 
#' @examples
#' list_all_sets()
list_all_sets <- function(){
  print(search_eurostat("*", fixed = FALSE) %>% 
          select(title, code) %>%
          arrange(code), n = Inf)
}