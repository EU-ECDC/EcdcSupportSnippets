# Plot dotplot
#'
#' This is a function for plotting dotplots the right way round. It primarily uses
#' [ggplot2::ggplot()] with a bit of [dplyr::inner_join()].
#' 
#' @param data Dataset to use, defaults to cars
#' @param var Desired variable for plotting, defaults to "speed"
#' @export
#' @importFrom dplyr inner_join
#' @importFrom ggplot2 ggplot
#' @examples
#' dotplot(data = cars, var = "speed")
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
