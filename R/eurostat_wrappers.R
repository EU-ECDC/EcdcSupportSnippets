#' Get both data set and information on it
#' 
#' This is a wrapper for the Eurostat package which retrieves both the data and
#' information about that data and returns it as a list
#' 
#' @param dataset code of Eurostat dataset to retrieve
#' @export
#' @importFrom eurostat get_eurostat search_eurostat
#' @import dplyr
#' @examples
#' data_and_info()
#' @seealso [list_all_sets() least_missings()]
data_and_info <- function(dataset = "aact_ali01", ...){
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
#' @seealso [data_and_info() least_missings()]
list_all_sets <- function(){
  print(search_eurostat("*", fixed = FALSE) %>% 
          select(title, code) %>%
          arrange(code), n = Inf)
}

#' Find dataset from year with least missings
#' 
#' @param dataset code of Eurostat dataset to retrieve
#' @export
#' @importFrom stringr str_replace_all
#' @importFrom lubridate dmy as.duration
#' @import dplyr
#' @examples
#' least_missings()
#' @seealso [data_and_info() list_all_sets()]
least_missings <- function(dataset = "ilc_lvho05a", ...){
  eur <- data_and_info(dataset = dataset)
  data <- eur$data
  info <- eur$info
  update <- info$`last update of data`
  update <- dmy(str_replace_all(string = update, 
                                pattern = "[.]", replacement = "-"))
  # Find time with least missing
  time_vals <- unique(data$time)
  mis <- c()
  for (i in 1:length(time_vals)){
    mis[i] <- sum(is.na(data %>% filter(time == time_vals[i])))
  }
  opt_time <- time_vals[which.min(mis)]
  # How far is this from recent update (in days)?
  elapsed <- as.duration(opt_time %--% update) / ddays(1)
  data <- data %>% filter(time == opt_time)
  mis_full <- (sum(is.na(data)) / dim(data)[1]) * 100
  mis_col <- (colSums(is.na(data)) / dim(data)[1]) * 100
  # Save outputs
  out <- list(times = list(optimal = opt_time,
                           last_updated = update,
                           days_elapsed = elapsed),
              percentage_missing = list(overall = mis_full,
                                        by_vars = mis_col),
              data = data)
  return(out)
}
