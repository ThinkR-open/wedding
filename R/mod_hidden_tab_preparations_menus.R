#' hidden_tab_preparations_menus UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_hidden_tab_preparations_menus_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    tags$br(style = "line-height: 20px"),
    
    fluidRow(
      align = "center",
      column(
        width = 4,
        style = "border-right:1px solid",
        h1("Vin d\'honneur"),
        fluidRow(
          column(width = 4,
                 h4("Portions adultes"),
                 textOutput(ns("number_adults_menu_cocktail"))),
          column(width = 4,
                 h4("Portions ados"),
                 textOutput(ns("number_teens_menu_cocktail"))),
          column(width = 4,
                 h4("Portions enfants"),
                 textOutput(ns("number_kids_menu_cocktail"))),
        )
      ),
      column(
        width = 4,
        style = "border-right:1px solid",
        h1("D\u00eener"),
        fluidRow(
          column(width = 4,
                 h4("Portions adultes"),
                 textOutput(ns("number_adults_menu_diner"))),
          column(width = 4,
                 h4("Portions prestataires"),
                 textOutput(ns("number_service_provider_menu_diner"))),
          column(width = 4,
                 h4("Portions enfants"),
                 textOutput(ns("number_kids_menu_diner")))
        )
      ),
      column(
        width = 4,
        h1("Retour"),
        fluidRow(
          column(width = 6,
                 h4("Portions adultes"),
                 textOutput(ns("number_adults_menu_sunday"))),
          column(width = 6,
                 h4("Portions enfants"),
                 textOutput(ns("number_kids_menu_sunday")))
        )
      )
      
    ),
    
    tags$br(style = "line-height: 20px"),
    
    fluidRow(
      align = "center",
      DT::dataTableOutput(ns("table_menus_diets"), width = "70%")
    )
    
  )
  
}
    
#' hidden_tab_preparations_menus Server Functions
#'
#' @noRd 
mod_hidden_tab_preparations_menus_server <- function(id, r_global = r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    output$number_adults_menu_cocktail <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Adulte'",
                                                  "here_cocktail == 'Oui'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_teens_menu_cocktail <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Ado'",
                                                  "here_cocktail == 'Oui'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_kids_menu_cocktail <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Enfant'",
                                                  "here_cocktail == 'Oui'",
                                                  "menu_diner == 'Menu enfant'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_adults_menu_diner <- renderText({
      
      count_confirmations(filter_confirmation = c("menu_diner == 'Menu adulte'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_service_provider_menu_diner <- renderText({
      
      "5"
      
    })
    
    output$number_kids_menu_diner <- renderText({
      
      count_confirmations(filter_confirmation = c("here_diner == 'Oui'",
                                                  "menu_diner == 'Menu enfant'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_adults_menu_sunday <- renderText({
      
      count_confirmations(filter_confirmation = c("(type == 'Adulte' | type == 'Ado')",
                                                  "here_sunday == 'Oui'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$number_kids_menu_sunday <- renderText({
      
      count_confirmations(filter_confirmation = c("type == 'Enfant'",
                                                  "here_sunday == 'Oui'",
                                                  "menu_diner == 'Menu enfant'"), 
                          data_guests = r_global$data_guests)
      
    })
    
    output$table_menus_diets <- DT::renderDataTable({
      
      r_global$data_guests %>% 
        select(name, special_diet, here_cocktail, here_diner, menu_diner, here_sunday) %>% 
        rename(
          stats::setNames(c("name", "special_diet", "here_cocktail", "here_diner", "menu_diner", "here_sunday"), 
                          c("Nom", "R\u00e9gime sp\u00e9cial", "Pr\u00e9sence vin d\'honneur", "Pr\u00e9sence d\u00eener", "Menu d\u00eener", "Pr\u00e9sence retour") 
          )
        )
      
    })
 
  })
  
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_menus_ui("hidden_tab_preparations_menus_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_menus_server("hidden_tab_preparations_menus_ui_1")
