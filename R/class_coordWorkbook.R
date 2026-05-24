#' openxlsx2::wbWorkbook extension
#'
#' @description This extends the wbWorkbook class from the openxlsx2 package
#' with several new fields and functions
#'
#' @noRd
.onLoad <- function(libname, pkgname) {
  openxlsx2::wbWorkbook$set("public", "from_crs",  overwrite = TRUE, NULL)
  openxlsx2::wbWorkbook$set("public", "to_crs", overwrite = TRUE,  NULL)
  openxlsx2::wbWorkbook$set("public", "from_x_name",  overwrite = TRUE, NULL)
  openxlsx2::wbWorkbook$set("public", "to_x_name",  overwrite = TRUE, NULL)
  openxlsx2::wbWorkbook$set("public", "from_y_name",  overwrite = TRUE, NULL)
  openxlsx2::wbWorkbook$set("public", "to_y_name",  overwrite = TRUE, NULL)
  openxlsx2::wbWorkbook$set("public", "add_coords", overwrite = TRUE,
                     function() {
                       df <- openxlsx2::wb_data(self)
                       coords_df <- convert_coords(df,
                                                   self$from_x_name,
                                                   self$from_y_name,
                                                   self$from_crs,
                                                   self$to_crs)
                       self$add_data(x = coords_df, start_col = ncol(df) + 1)
                       invisible(self)
                     }
  )
}
