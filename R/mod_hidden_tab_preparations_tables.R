#' hidden_tab_preparations_tables UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_hidden_tab_preparations_tables_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    tags$br(style = "line-height: 20px")
    
  )
  
}
    
#' hidden_tab_preparations_tables Server Functions
#'
#' @noRd 
mod_hidden_tab_preparations_tables_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_tables_ui("hidden_tab_preparations_tables_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_tables_server("hidden_tab_preparations_tables_ui_1")
