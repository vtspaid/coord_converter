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
        shinyFiles::shinyFilesButton(ns("file_explorer"),
                                     "Select a File",
                                     "file selector",
                                     multiple = FALSE,
                                     style = "margin-bottom: 10px;"),
        selectInput(ns("from_x"), "x/Longitude column", choices = ""),
        selectInput(ns("from_y"), "y/Latitude column", choices = ""),
        selectInput(ns("from_crs"), "Current CRS", choices = crs_list),
        selectInput(ns("to_crs"), "New CRS", choices = crs_list),
        textInput(ns("to_x"), "new x name", "x"),
        textInput(ns("to_y"), "new y name", "y"),
        fluidRow(
          col_6(actionButton(ns("copy"), "Copy Results")),
          col_6(actionButton(ns("convert"), "Convert Coords"))
        )
    )
}

#' sidebar Server Functions
#'
#' @noRd
mod_sidebar_server <- function(id, r6, file_trigger, convert_trigger){
  moduleServer(id, function(input, output, session){
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

        r6$active_sheet <- openxlsx2::wb_data(r6$wb)
        colnames(r6$active_sheet)[
          which(is.na(colnames(r6$active_sheet)))
          ] <- "NA"

        updateSelectInput(inputId = "from_x", choices = colnames(r6$active_sheet))
        updateSelectInput(inputId = "from_y", choices = colnames(r6$active_sheet))
      }

      r6$from_x_name <- input$from_x
      r6$from_y_name <- input$from_y
      r6$to_x_name <- input$to_x
      r6$to_y_name <- input$to_y
      r6$from_crs <- input$from_crs
      r6$to_crs <- input$to_crs

      golem::cat_dev("trigger file_trigger\n")
      gargoyle::trigger(file_trigger)
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
      r6$active_sheet <- openxlsx2::wb_data(r6$wb)
      colnames(r6$active_sheet)[
        which(is.na(colnames(r6$active_sheet)))
      ] <- "NA"

      r6$active_sheet <- convert_coords(r6$active_sheet,
                                        r6$from_x_name,
                                        r6$from_y_name,
                                        r6$from_crs,
                                        r6$to_crs,
                                        r6$to_x_name,
                                        r6$to_y_name)
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
