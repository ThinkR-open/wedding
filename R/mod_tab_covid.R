#' tab_covid UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab_covid_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    tags$div(class="landing-wrapper",
             
             # Image fond d'écran
             tags$div(class = "landing-block background-content",
                      
                      img(src = "www/wedding-background.jpg")
                      
             ),
             
             # Texte
             tags$div(class = "landing-block foreground-content",
                      tags$div(class = "foreground-text",
                               tags$p("Les restrictions sanitaires", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:3px; text-align: center"),
                               tags$p("A l\'heure actuelle, les f\u00eates de mariage sont interdites.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
                               tags$p("Nous avons bon espoir d\'avoir l\'autorisation de le faire en octobre.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
                               tags$p("Nous viendrons indiquer ici les mesures sanitaires si certaines sont obligatoires au moment de l\'\u00e9v\u00e9nement (port du masque, etc.).", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
                      )
             )
    )
    
  )
  
}
    
#' tab_covid Server Functions
#'
#' @noRd 
mod_tab_covid_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
 
  })
}
    
## To be copied in the UI
# mod_tab_covid_ui("onglet_covid_ui_1")
    
## To be copied in the server
# mod_tab_covid_server("onglet_covid_ui_1")
