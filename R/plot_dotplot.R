# Load packages
library(dplyr) # For working with data
library(ggplot2) # For plotting

# Get data from dotplot
dotplot <- function(data = cars, var = "speed"){
  p <- ggplot2::ggplot(data = data,
                       mapping = aes(x = factor(get(var)))) +
    geom_dotplot()
  # Add factor labels to data
  plot_data <- dplyr::inner_join(layer_data(p, 1),
                                 tibble(group = unique(layer_data(p, 1)$group),
                                        cat = levels(factor(data[[var]]))),
                                 by = "group")
  # Plot points
  ggplot(data = plot_data,
         mapping = aes(x = cat, y = countidx)) +
    geom_point()
}
