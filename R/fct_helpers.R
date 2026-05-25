#' helpers
#'
#' @description A fct function
#'
#' @return The return value, if any, from executing the function.
#'
#' @noRd
convert_coords <- function(x, from_x_name,
                           from_y_name,
                           from_crs,
                           to_crs,
                           to_x_name,
                           to_y_name,
                           decimals) {
  x <- as.data.frame(x)

  if (to_x_name %in% colnames(x) || to_y_name %in% colnames(x)) {
    stop("new x or y names are not unique")
  }

  coords <- x[, c(from_x_name, from_y_name)]
  coords <- terra::vect(coords,
                        geom = c(from_x_name, from_y_name),
                        crs = from_crs)
  coords <- terra::project(coords, to_crs)
  coords <- as.data.frame(coords, geom = "XY")

  x[to_x_name] <- round(coords$x, decimals)
  x[to_y_name] <- round(coords$y, decimals)
  x
}


#' helpers
#'
#' @description A fct function
#'
#' @param x A vector of column names
#' @param y A vector of valid coordinate names
#'
#' @return The vector x, ordered so that if any valid coordinate names exist
#' they are placed first.
#'
#' @noRd
get_likely_columns <- function(x, y) {
  index <- which(tolower(x) %in% y)
  if (length(index > 0)) {
    return(c(x[index], x[-index]))
  } else {
    return(x)
  }
}
