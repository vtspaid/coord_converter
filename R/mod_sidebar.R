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
mod_sidebar_server <- function(id){
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
  })
}

## To be copied in the UI
# mod_sidebar_ui("sidebar_1")

## To be copied in the server
# mod_sidebar_server("sidebar_1")
