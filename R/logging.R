save_log <- function(name = "script.R"){
  # Open connection
  con <- file(paste0(unlist(strsplit(name, ".R")), ".log"))
  sink(con, append = TRUE)
  sink(con, append = TRUE, type = "message")
  # Run code
  source(name, echo = TRUE, max.deparse.length = 10000)
  # Close connections
  on.exit(closeAllConnections())
}
