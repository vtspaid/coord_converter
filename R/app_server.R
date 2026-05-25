c#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  # Create triggers
  gargoyle::init("file_loaded", "convert")

  # Create r6 object
  val_holder <- myr6$new()

  mod_sidebar_server("sidebar", r6 = val_holder,
                     file_trigger = "file_loaded",
                     convert_trigger = "convert")

  mod_datatable_server("datatable", r6 = val_holder, w = "file_loaded")
}
