library(eurostat)
library(dplyr)

eurostat_dataset_and_info <- function(dataset = "aact_ali01"){
  out <- list()
  out$data <- get_eurostat(id = dataset)
  out$info <- search_eurostat("*", fixed = FALSE) %>% 
    filter(code == dataset)
  return(out)
}

list_all_sets <- function(){
  print(search_eurostat("*", fixed = FALSE) %>% 
          select(title, code) %>%
          arrange(code), n = Inf)
}
