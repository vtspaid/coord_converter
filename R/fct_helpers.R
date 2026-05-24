#' helpers
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
convert_coords <- function(x, from_x_name, from_y_name, from_crs, to_crs) {
  x <- as.data.frame(x)
  coords <- x[, c(from_x_name, from_y_name)]
  coords <- terra::vect(coords,
                        geom = c(from_x_name, from_y_name),
                        crs = from_crs)
  coords <- terra::project(coords, to_crs)
  coords <- as.data.frame(coords, geom = "XY")
  coords
}

