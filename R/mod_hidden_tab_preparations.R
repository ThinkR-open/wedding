#' hidden_tab_preparations UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom readr read_csv locale
#' @importFrom dplyr filter count
mod_hidden_tab_preparations_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    tags$br(style = "line-height: 60px"),
    
    fluidRow(
      column(
        width = 12,
        align = "center",
        passwordInput(
          inputId = ns("password_tab_preparation"), 
          label = "Mot de passe : (onlyforbride)"
        )
      )
    ),
    
    tags$br(style = "line-height: 60px"),
    
    uiOutput(ns("show_tab_preparation"))
 
  )
  
}
    
#' hidden_tab_preparations Server Functions
#'
#' @noRd 
mod_hidden_tab_preparations_server <- function(id, r_global) {
  
  moduleServer(id, function(input, output, session) {
    
    ns <- session$ns
    
    # Password OK + renderUI
    observeEvent(input$password_tab_preparation, {
      
      if (input$password_tab_preparation == Sys.getenv("PWD_COUPLE")) {
        
        output$show_tab_preparation <- renderUI({
          
          tagList(tabsetPanel(
            type = "tabs",
            
            tabPanel(
              title = "D\u00e9penses",
              mod_hidden_tab_preparations_expenses_ui(ns("hidden_tab_preparations_expenses_ui_1"))
            ),
            
            tabPanel(
              title = "Invit\u00e9s",
              mod_hidden_tab_preparations_guests_ui(ns("hidden_tab_preparations_guests_ui_1"))
            ),
            
            tabPanel(
              title = "Informations pour les menus",
              mod_hidden_tab_preparations_menus_ui(ns("hidden_tab_preparations_menus_ui_1"))    
            ),
            
            tabPanel(
              title = "Plan de table",
              mod_hidden_tab_preparations_tables_ui(ns("hidden_tab_preparations_tables_ui_1"))
            )
            
          ))
          
        })
        
      }
      
    })
    
    # Submodules servers
    mod_hidden_tab_preparations_expenses_server("hidden_tab_preparations_expenses_ui_1", r_global = r_global)
    mod_hidden_tab_preparations_guests_server("hidden_tab_preparations_guests_ui_1", r_global = r_global)
    mod_hidden_tab_preparations_menus_server("hidden_tab_preparations_menus_ui_1", r_global = r_global)
    mod_hidden_tab_preparations_tables_server("hidden_tab_preparations_tables_ui_1", r_global = r_global)
    
  })
  
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_ui("hidden_tab_preparations_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_server("hidden_tab_preparations_ui_1")
