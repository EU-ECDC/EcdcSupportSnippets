#library(scholar)
library(magrittr)
library(xml2)
library(rvest)

forward_search <- function(article = "17043760687520762667", ...){
  url <- "https://scholar.google.se/scholar?cites="
  # url <- "https://scholar.google.se/scholar?cluster="
  res <- read_html(paste0(url, article))
  # Want to get hold of class gs_ri
  (res %>% html_nodes("div.gs_ri"))
  xml_find_all(x = res, xpath = "//div[@class = 'gs_ri']")
  #(res %>% html_nodes("div#gs_res_ccl"))[1] %>% xml_children
            ### Not sure why this is empty ###
  xml_find_all(x = res, xpath = "//div[@id = 'gs_res_ccl_mid']")
}
