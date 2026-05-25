#' sidebar UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_sidebar_ui <- function(id) {
  ns <- NS(id)
  tagList(
        fluidRow(
          col_5(shinyFiles::shinyFilesButton(ns("file_explorer"),
                                     "Select a File",
                                     "file selector",
                                     multiple = FALSE,
                                     style = "margin-bottom: 10px;")),
          col_7(textOutput(ns("filename")))
        ),
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


    # From microsoft Copilot.
    get_roots <- function() {
      sys <- Sys.info()[["sysname"]]

      if (sys == "Windows") {
        # All available drive letters
        drives <- system("wmic logicaldisk get name", intern = TRUE)
        drives <- gsub("Name", "", drives)
        drives <- trimws(drives)
        drives <- drives[nchar(drives) > 0]

        # Add user
        drives <- c(paste0("C://users/", Sys.info()[["user"]], "/documents"), drives)
        names(drives) <- drives

        return(drives)
      }

      if (sys == "Darwin") {
        # macOS
        return(c(Home = "~", Volumes = "/Volumes"))
      }

      # Linux / Unix
      c(Home = "~", Root = "/")
    }

    roots <- get_roots()

    shinyFiles::shinyFileChoose(input,
                                'file_explorer',
                                session = session,
                                roots = roots,
                                filetypes=c('csv', 'xlsx'))

    observeEvent(input$file_explorer, {
      fileinfo <- shinyFiles::parseFilePaths(roots, input$file_explorer)
      r6$filepath <- as.character(fileinfo$datapath)

      if (length(r6$filepath) > 0 && file.exists(r6$filepath)) {
        r6$wb <- openxlsx2::wb_load(r6$filepath)

        r6$active_sheet <- openxlsx2::wb_data(r6$wb, sheet = 1)
        colnames(r6$active_sheet)[
          which(is.na(colnames(r6$active_sheet)))
          ] <- "NA"

        updateSelectInput(inputId = "from_x", choices = colnames(r6$active_sheet))
        updateSelectInput(inputId = "from_y", choices = colnames(r6$active_sheet))
        updateSelectInput(inputId = "sheet", choices = r6$wb$get_sheet_names())

        r6$from_x_name <- input$from_x
        r6$from_y_name <- input$from_y
        r6$to_x_name <- input$to_x
        r6$to_y_name <- input$to_y
        r6$from_crs <- input$from_crs
        r6$to_crs <- input$to_crs

        gargoyle::trigger(file_trigger)
      }
    })

    # show or hide the sheet input based on file extension
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
      r6$active_sheet <- openxlsx2::wb_data(r6$wb, sheet = input$sheet)
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
