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
    
    tags$br(style = "line-height: 20px"),
    
    fluidRow(
      align = "center",
      column(width = 3,
             DT::dataTableOutput(ns("table_seating_plan"), width = "70%")),
      column(width = 9,
             plotOutput(ns("plot_seating_plan")))
      
    )
    
  )
  
}
    
#' hidden_tab_preparations_tables Server Functions
#'
#' @noRd 
mod_hidden_tab_preparations_tables_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
 
    output$table_seating_plan <- DT::renderDataTable({
      
      r_global$data_guests %>% 
        select(name, table, here_diner) %>% 
        rename(
          stats::setNames(c("name", "table", "here_diner"), 
                          c("Nom", "Table", "Pr\u00e9sence d\u00eener") 
          )
        )
      
    })
    
    output$plot_seating_plan <- renderPlot({
      
      r_global$data_guests %>%
        plot_all_seating_plans(font_family_table = "Old Script", font_family_guests = "MrsEavesItalic")
      
    }, height = 1000, width = 1000)
    
  })
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_tables_ui("hidden_tab_preparations_tables_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_tables_server("hidden_tab_preparations_tables_ui_1")
