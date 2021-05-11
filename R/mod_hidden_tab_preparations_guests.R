#' hidden_tab_preparations_guests UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_hidden_tab_preparations_guests_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    tags$br(style = "line-height: 20px"),
    
    fluidRow(
      
      column(
        width = 4,
        align = "center",
        h1("Nombre de confirmations"),
        span(textOutput(ns(
          "number_confirmations"
        )),
        style = "font-family: \'Bauer Bodoni Std 1\'; font-size:20px; letter-spacing:5px; color: black; text-align: center"),
        tags$br(style = "line-height: 20px"),
        
        fluidRow(
          column(width = 4,
                 h4("Adultes"),
                 textOutput(ns("number_adults"))),
          column(width = 4,
                 h4("Adolescents"),
                 textOutput(ns("number_teenagers"))),
          column(width = 4,
                 h4("Enfants"),
                 textOutput(ns("number_kids")))
        ),
        
        tags$br(style = "line-height: 20px"),
        h1("Nombre de faire-parts"),
        span(textOutput(ns(
          "number_announcements"
        )),
        style = "font-family: \'Bauer Bodoni Std 1\'; font-size:20px; letter-spacing:5px; color: black; text-align: center")
      ),
      
      column(width = 8,
             DT::dataTableOutput(ns("list_guest")))
    )
    
  )
  
}
    
#' hidden_tab_preparations_guests Server Functions
#'
#' @noRd 
mod_hidden_tab_preparations_guests_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    output$number_confirmations <- renderText({
      
      count_confirmations(filter_confirmation = "(here_cocktail == 'Oui' | here_diner == 'Oui' | here_sunday == 'Oui')", 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_adults <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Adulte'",
                                                  "(here_cocktail == 'Oui' | here_diner == 'Oui' | here_sunday == 'Oui')"), 
                          data_guests = r_global$data_guests)

    })
    
    output$number_teenagers <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Ado'",
                                                  "(here_cocktail == 'Oui' | here_diner == 'Oui' | here_sunday == 'Oui')"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_kids <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Enfant'",
                                                  "(here_cocktail == 'Oui' | here_diner == 'Oui' | here_sunday == 'Oui')"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_announcements <- renderText({
      
      count_confirmations(filter_confirmation = "announcement == 'Yes'", 
                          data_guests = r_global$data_guests)
      
    })
    
    output$list_guest <- DT::renderDataTable({
      
      r_global$data_guests %>% 
        select(name, type, here_cocktail, here_diner, here_sunday) %>% 
        rename(
          stats::setNames(c("name", "type", "here_cocktail", "here_diner", "here_sunday"), 
                          c("Nom", "Cat\u00e9gorie", "Pr\u00e9sence vin d\'honneur", "Pr\u00e9sence d\u00eener", "Pr\u00e9sence retour") 
          )
        )
      
    })
 
  })
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_guests_ui("hidden_tab_preparations_guests_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_guests_server("hidden_tab_preparations_guests_ui_1")
