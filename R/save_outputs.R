#' Save plots in various formats
#' 
#' This is a wrapper for the outputs from grDevices saving plots in all manner of
#' formats.
#' 
#' @param fig plot
#' @param filename name of plot
#' @param location location plot saves to (defaults to subfolder called Figures)
#' @param width width of figure defaults to 4.8 (corresponding to 480px
#' for those exports which have default units px)
#' @param height height of figure defaults to 4.8 (corresponding to 480px
#' for those exports which have default units px)
#' @param types output formats
#' @export
#' @importFrom here here
#' @import dplyr
#' @import rvg
#' @import officer
#' @examples
#' p <- ggplot2::qplot(c(1, 2, 3, 4))
#' eurosurveillance_types <- c("pdf", "eps", "wmf", "emf", "svg")
#' save_plot(fig = p, filename = "test", types = eurosurveillance_types)
#' @seealso [save_data()]
save_plot <- function(fig, filename = "Rplot%03d",
                      location = "Figures/",
                      width = 4.8, height = 4.8,
                      types = c("bmp", "png", "jpeg", "tiff", "pdf", ...)){
  # Create Figures folder if it does not already exist
  ifelse(!dir.exists(here(location)),
         dir.create(here(location)), FALSE)
  # Inform user of location plots are being saved to
  message(paste0("Saving plots to ", here(location)))
  # BMP
  if("bmp" %in% types)
    bmp(filename = here(paste0(location, filename, ".bmp")),
        width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # EPS
  if("eps" %in% types)
    setEPS()
    postscript(file = here(paste0(location, filename, ".eps")),
               width = width, height = height,
               horizontal = FALSE, onefile = FALSE, paper = "special")
    print(fig)
    dev.off()
  # JPEG
  if("jpeg" %in% types | "jpg" %in% types)
    jpeg(filename = here(paste0(location, filename, ".jpg")),
         width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # PDF
  if("pdf" %in% types)
    pdf(file = here(paste0(location, filename, ".pdf")),
        width = width, height = height)
    print(fig)
    dev.off()
  # PNG
  if("png" %in% types)
    png(filename = here(paste0(location, filename, ".png")),
        width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # PPT
  if("ppt" %in% types)
    doc <- read_pptx() %>%
      add_slide(layout = "Title and Content", master = "Office Theme") %>%
      ph_with_vg_at(code = print(fig), left = 1, top = 2, width = 6, height = 4)
    print(doc, target = here(paste0(location, filename, ".pptx")))
    while(!is.null(dev.list())) dev.off()
  # PS
  if("ps" %in% types)
    postscript(file = here(paste0(location, filename, ".ps")),
               width = width, height = height)
    print(fig)
    dev.off()
  # SVG
  if("svg" %in% types)
    svg(filename = here(paste0(location, filename, ".svg")),
        width = width, height = height)
    print(fig)
    dev.off()
  # TEX
  if("tex" %in% types)
    pictex(file = here(paste0(location, filename, ".tex")),
           width = width, height = height)
    print(fig)
    dev.off()
  # TIFF
  if("tiff" %in% types | "tif" %in% types)
    tiff(filename = here(paste0(location, filename, ".tif")),
         width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # WMF
  if("wmf" %in% types)
    win.metafile(filename = here(paste0(location, filename, ".wmf")),
                 width = width, height = height)
    print(fig)
    dev.off()
}
  
#' Save data in various formats
#' 
#' This is a wrapper for saving data to local machines.
#' 
#' @param obj object to be saved
#' @param filename name of object
#' @param location location object saves to (defaults to subfolder called Data)
#' @param types output formats
#' @export
#' @importFrom here here
#' @seealso [save_plot()]
save_data <- function(obj, 
                      filename = paste0("data", sprintf(fmt = "%03d", 1)),
                      location = "Data/",
                      types = c("rds", "csv")){
  # Create Data folder if it does not already exist
  ifelse(!dir.exists(here(location)),
         dir.create(here(location)), FALSE)
  # Inform user of location outputs are being saved to
  message(paste0("Saving outputs to ", here(location)))
  # RDS
  if("rds" %in% types)
    saveRDS(object = obj, file = here(paste0(location, filename, ".rds")))
  # CSV
  if("csv" %in% types)
    write.csv(x = obj, file = here(paste0(location, filename, ".csv")))
}
