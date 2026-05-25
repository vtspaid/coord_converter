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
  index <- which(complete.cases(coords))
  coords <- terra::vect(coords,
                        geom = c(from_x_name, from_y_name),
                        crs = from_crs)
  coords <- terra::project(coords, to_crs)
  coords <- as.data.frame(coords, geom = "XY")

  x[index, to_x_name] <- round(coords$x, decimals)
  x[index, to_y_name] <- round(coords$y, decimals)
  x
}


#' get_likely_columns
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

#' guess_crs
#'
#' @description A fct function
#'
#' @param x A two column data frame of coordinates where column one is x and
#' column two is y
#'
#' @return Suggested from and to CRSs
#'
#' @noRd
guess_crs <- function(x) {
  vals <- unlist(x)
  vals <- vals[!is.na(vals)]
  if (sum(vals >= -180 & vals <=180) == length(vals)) {
    from_crs <- "EPSG:4326"

    test_point <- na.omit(x)[1, 1]
    zone <- floor((test_point + 180) / 6) + 1
    to_crs <- paste0("EPSG:269", zone)
  } else {
    from_crs <- "unknown"
    to_crs <- "unknown"
  }

  return(list(from_crs = from_crs,
              to_crs = to_crs))

}
