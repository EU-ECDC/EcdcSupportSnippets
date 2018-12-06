library(here)

save_plot <- function(fig, filename = "Rplot%03d",
                      location = "Figures/",
                      width = 4.8, height = 4.8,
                      types = c("bmp", "png", "jpeg", "tiff", "pdf")){
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
  # PNG
  if("png" %in% types)
    png(filename = here(paste0(location, filename, ".png")),
        width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # JPEG
  if("jpeg" %in% types | "jpg" %in% types)
    jpeg(filename = here(paste0(location, filename, ".jpg")),
         width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # TIFF
  if("tiff" %in% types | "tif" %in% types)
    tiff(filename = here(paste0(location, filename, ".tif")),
         width = width * 100, height = height * 100)
    print(fig)
    dev.off()
  # PDF
  if("pdf" %in% types)
    pdf(file = here(paste0(location, filename, ".pdf")),
        width = width, height = height)
    print(fig)
    dev.off()
}
  
# test
p <- ggplot2::qplot(c(1, 2, 3, 4))
save_plot(fig = p)
