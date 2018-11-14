# Load packages
library(dplyr) # For working with data
library(ggplot2) # For plotting

# Get data from dotplot
p <- ggplot2::ggplot(data = cars,
                     mapping = aes(x = factor(speed))) +
  geom_dotplot()

# Add factor labels to data
plot_data <- dplyr::inner_join(layer_data(p, 1),
                               tibble(group = unique(layer_data(p, 1)$group),
                                      cat = levels(factor(cars$speed))),
                               by = "group")

# Plot points
ggplot(data = plot_data,
       mapping = aes(x = cat, y = countidx)) +
  geom_point()

#TODO: Turn into function