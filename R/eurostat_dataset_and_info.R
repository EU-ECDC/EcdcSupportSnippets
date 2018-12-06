library(eurostat)

eurostat_dataset_and_info <- function(dataset = "aact_ali01"){
  out <- list()
  out$data <- get_eurostat(id = dataset)
  out$info <- search_eurostat(" ") %>% 
    filter(code == dataset)
  return(out)
}
