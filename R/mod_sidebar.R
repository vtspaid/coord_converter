#' sidebar UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom gargoyle watch
mod_sidebar_ui <- function(id) {
  ns <- NS(id)
  tagList(
        fileInput(ns("file_input"),
                  "Select a File",
                  accept = c(".xlsx", ".csv")),

        shinyjs::hidden(
          selectInput(ns("sheet"), "Select Sheet", choices = "")
        ),
        selectInput(ns("from_x"), "x/Longitude column", choices = ""),
        selectInput(ns("from_y"), "y/Latitude Column", choices = ""),
        selectInput(ns("from_crs"), "Current CRS", choices = crs_list),
        selectInput(ns("to_crs"), "New CRS", choices = crs_list),
        textInput(ns("to_x"), "New x Name", "x"),
        textInput(ns("to_y"), "New y Name", "y"),
        numericInput(ns("decimals"), "Decimals", 0, min = 0, step = 1),
        actionButton(ns("convert"), "Convert Coordinates")
    )
}

#' sidebar Server Functions
#'
#' @importFrom gargoyle watch
#' @noRd
mod_sidebar_server <- function(id, r6, file_trigger, convert_trigger){
  moduleServer(id, function(input, output, session) {
    ns <- session$ns

    observeEvent(input$file_input, {

      r6$filepath <- input$file_input$datapath

      if (length(r6$filepath) > 0 && file.exists(r6$filepath)) {

        if (tools::file_ext(r6$filepath) == "xlsx") {
          r6$wb <- openxlsx2::wb_load(r6$filepath)

          r6$active_sheet <- openxlsx2::wb_data(r6$wb, sheet = 1)
          updateSelectInput(inputId = "sheet", choices = r6$wb$get_sheet_names())
        } else {
          r6$active_sheet <- readr::read_csv(r6$filepath)
        }

        colnames(r6$active_sheet)[
          which(is.na(colnames(r6$active_sheet)))
        ] <- "NA"

        cols <- colnames(r6$active_sheet)
        x_cols <- get_likely_columns(cols, x_coord_names)
        y_cols <- get_likely_columns(cols, y_coord_names)

        updateSelectInput(inputId = "from_x", choices = x_cols)
        updateSelectInput(inputId = "from_y", choices = y_cols)

        r6$from_x_name <- input$from_x
        r6$from_y_name <- input$from_y
        r6$to_x_name <- input$to_x
        r6$to_y_name <- input$to_y
        r6$from_crs <- input$from_crs
        r6$to_crs <- input$to_crs

        try ({
          crs_guess <- guess_crs(
            as.data.frame(r6$active_sheet)[, c(x_cols[1], y_cols[1])]
            )

          if (crs_guess$from_crs != "unknown") {
            updateSelectInput(inputId = "from_crs",
                              selected = crs_guess$from_crs)
            updateSelectInput(inputId = "to_crs",
                              selected = crs_guess$to_crs)
          }
          r6$from_crs <- crs_guess$from_crs
          r6$to_crs <- crs_guess$to_crs
        })

        gargoyle::trigger(file_trigger)
      }
    })

    # Show or hide the sheet input based on file extension
    gargoyle::on(file_trigger, {
      if(tools::file_ext(r6$filepath) == "xlsx") {
        shinyjs::show("sheet")
      } else {
        shinyjs::hide("sheet")
      }
    })

    observeEvent(input$sheet, {
      req(r6$wb)
      r6$active_sheet <- openxlsx2::wb_data(r6$wb, sheet = input$sheet)
      gargoyle::trigger(file_trigger)
    })

    # Print file name
    output$filename <- renderText({
      gargoyle::watch(file_trigger)
      req(r6$filepath)
      basename(r6$filepath)
    })

    observeEvent(input$from_x, {
      r6$from_x_name <- input$from_x
    })

    observeEvent(input$from_y, {
      r6$from_y_name <- input$from_y
    })

    observeEvent(input$to_x, {
      r6$to_x_name <- input$to_x
    })

    observeEvent(input$to_y, {
      r6$to_y_name <- input$to_y
    })

    observeEvent(input$from_crs, {
      r6$from_crs <- input$from_crs
    })

    observeEvent(input$to_crs, {
      r6$to_crs <- input$to_crs
    })

    observeEvent(input$convert, {

      if (tools::file_ext(r6$filepath) == "xlsx") {
        r6$wb <- openxlsx2::wb_load(r6$filepath)
        r6$active_sheet <- openxlsx2::wb_data(r6$wb, sheet = input$sheet)
      } else {
        r6$active_sheet <- readr::read_csv(r6$filepath)
      }

      colnames(r6$active_sheet)[
        which(is.na(colnames(r6$active_sheet)))
      ] <- "NA"

      tryCatch({
      r6$active_sheet <- convert_coords(r6$active_sheet,
                                        r6$from_x_name,
                                        r6$from_y_name,
                                        r6$from_crs,
                                        r6$to_crs,
                                        r6$to_x_name,
                                        r6$to_y_name,
                                        input$decimals)
      }, error = function(e) {
        # This code runs if an error occurs
        showNotification(paste("Error:", e$message), type = "error")
        return(NULL) # Return a safe value to prevent downstream crashes
      })

      gargoyle::trigger(file_trigger)
      gargoyle::trigger(convert_trigger)
      golem::cat_dev("convert_trigger triggered\n")
    })

  })
}

## To be copied in the UI
# mod_sidebar_ui("sidebar_1")

## To be copied in the server
# mod_sidebar_server("sidebar_1")
