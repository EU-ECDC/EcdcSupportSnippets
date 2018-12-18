#HIHSI029010 (Percentage of infants vaccinated against diphtheria)
#HIHSI029020 (Percentage of infants vaccinated against tetanus)
#HIHSI029030 (Percentage of infants vaccinated against pertussis)
#HIHSI029040 (Percentage of infants vaccinated against poliomyelitis)
#HIHSI029050 (Percentage of infants vaccinated against rubella)
#HIHSI029060 (Percentage of infants vaccinated against measles)
#HIHSI029090 (Percentage of infants vaccinated against mumps)

# Depends here, readxl
library(here)
library(readxl)

get_echi_data <- function(indic = c("HIHSI029010", "HIHSI029030", "HIHSI029040",
                                     "HIHSI029020", "HIHSI029060","HIHSI029090",
                                     "HIHSI029050"),
                          countries = c("EU", "Min", "Avg", "Max", "BE", "BG", 
                                        "CZ","DK", "DE", "EE", "IE", "EL", "ES",
                                        "FR", "HR", "IT", "CY", "LV", "LT", "LU",
                                        "HU", "MT", "NL", "AT", "PL", "PT", "RO",
                                        "SI", "SK", "FI", "SE", "UK", "IS", "NO",
                                        "CH", "ME", "RS", "MK", "AL", "TR", "BA"),
                          years = NULL, ...){
  indicators <- paste0(indic, sep = ",", collapse = "")
  locations <- paste0(countries, sep = ",", collapse = "")
  
  link <- paste0("https://webgate.ec.europa.eu/dyna/echi/datatool/tab_4xls.cfm?indiclist=",
                 indicators,
                 "&countries_box=",
                 locations,
                 "&years_box=",
                 years) # Seems to still produce years_box when specific years given 
  download.file(url = link, destfile = here("datatool.xls"))
  data <- read_xls(path = here("datatool.xls"), header = TRUE, skip = 2)
  return(data)
}

get_echi_data() # Doesn't seem to work

library(rvest)
