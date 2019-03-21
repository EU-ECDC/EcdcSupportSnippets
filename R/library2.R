# Wrapper for library that installs package first if it is not already installed
library2 <- function(pkg = "xtable"){
  if(!nzchar(system.file(package = pkg)))
    {install.packages(pkgs = pkg)}
  eval(parse(text = paste("library(", pkg, ")")))
}
