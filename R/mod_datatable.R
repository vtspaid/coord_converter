#' datatable UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_datatable_ui <- function(id) {
  ns <- NS(id)
  tagList(
    DT::DTOutput(ns("input_table"))#,
   # downloadButton(ns("dl"))
  )
}

#' datatable Server Functions
#'
#' @noRd
mod_datatable_server <- function(id, r6, w){
  moduleServer(id, function(input, output, session){
    ns <- session$ns
    output$input_table <- DT::renderDataTable({
      gargoyle::watch(w)
      req(r6$filepath)

      df <- r6$active_sheet
      validate(need(!is.null(df) && ncol(df) > 0, "Workbook has no data"))
      get_cols <- which(colnames(df) %in% c(r6$to_x_name, r6$to_y_name))
      DT::datatable(df,
                    extensions = c("Buttons"),
                    options = list(
                      select = TRUE,
                      dom = "Bfrtip",
                      buttons = list(
                        list(
                          extend = "copy",
                          text = "Copy New Coords to Clipboard",
                          title = NULL,
                          exportOptions = list(columns = get_cols)
                        )
                      )
                    )
      )
    }, server = FALSE)

    # output$dl <- downloadHandler(
    #   file = function() { "download.xlsx"},
    #   content = function(file) {
    #     writexl::write_xlsx(r6$active_sheet, format_headers = FALSE, path = file)
    #     }
    # )

  })
}

## To be copied in the UI
# mod_datatable_ui("datatable_1")

## To be copied in the server
# mod_datatable_server("datatable_1")
