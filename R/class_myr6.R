#' myr6
#'
#' @description A class generator function
#'
#' @noRd
myr6 <- R6::R6Class(
  classname = 'myr6',
  public = list(
    filepath = NULL,
    wb = NULL,
    active_sheet = NULL,
    from_crs = NULL,
    to_crs = NULL,
    from_x_name = NULL,
    to_x_name = NULL,
    from_y_name = NULL,
    to_y_name = NULL
  )
)
