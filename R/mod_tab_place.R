#' tab_place UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab_place_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    tags$br(style = "line-height: 80px"),
    
    fluidRow(
      
      column(
        width = 6,
        tags$div(img(src = "www/bellenoe.jpg"), style = "text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Manoir de Belle-No\u00eb", style = "font-family: \'Bauer Bodoni Std 1\'; letter-spacing:3px; text-align: center"),
        tags$p("Dol-de-Bretagne", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
        ),
      
      column(
        width = 6,
        align = "center",
        leafletOutput(
          outputId = ns("carte_belle_noe"),
          height = 341,
          width = 512
        )
      )
    ),
    
    # Parking
    tags$br(style = "line-height: 80px"),
    
    tags$p("Un parking est disponible sur le domaine.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
    
    tags$br(style = "line-height: 80px"),
    
    # Hébergements
    fluidRow(
      
      column(
        width = 6,
        tags$br(style = "line-height: 45px"),
        tags$p("Les h\u00e9bergements sur place", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:3px; text-align: center"),
        tags$p("Le domaine a une capacit\u00e9 d\u2019h\u00e9bergements de 40/42 personnes.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Les h\u00e9bergements sont compos\u00e9s de 5 chambres d\'h\u00f4tes,", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("de petites chambres dans les d\u00e9pendances, et de 2 g\u00eetes.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Vous trouverez plus d\'informations dans l\'onglet H\u00e9bergements.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Le tarif sera de 25 euros/nuit/personne pour une h\u00e9bergement sur place.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("La priorit\u00e9 sera donn\u00e9e \u00e0 nos copains qui picolent beaucoup (ah ah) et aux familles.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Un espace camping avec toilettes s\u00e8ches est \u00e9galement disponible.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
      ),
      
      column(
        width = 6,
        tags$div(img(src = "www/bellenoe_dortoir.jpg"), 
                 style = "text-align: center"),
      )
      
    ),
    
    tags$br(style = "line-height: 80px"),
    
    # Salon des enfants
    fluidRow(
      
      column(
        width = 6,
        tags$div(img(src = "www/bellenoe_enfants.jpg"), 
                 style = "text-align: center"),
      ),
      
      column(
        width = 6,
        tags$br(style = "line-height: 120px"),
        tags$p("Le salon des enfants", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 30px; letter-spacing:3px; text-align: center"),
        tags$p("Petite d\u00e9pendance de 45m\u00b2 proche des salles de r\u00e9ception et", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("\u00e9quip\u00e9e pour y recevoir les enfants sous la surveillance de baby-sitters.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Au premier \u00e9tage, un petit dortoir \u00e9quip\u00e9 de 8 lits (une personne).", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")      )
      
    )
 
  )
}
    
#' tab_place Server Functions
#'
#' @noRd 
mod_tab_place_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    output$carte_belle_noe <- renderLeaflet({
      
      get_map_wedding(
        data_markers = tibble(
          longitude = -1.7129955029636943, 
          latitude = 48.53024518235586,
          name = "Manoir de Belle-No\u00eb"),
        icon_markers = "heart"
      )
                            
    })
 
  })
}
    
## To be copied in the UI
# mod_tab_place_ui("tab_place_ui_1")
    
## To be copied in the server
# mod_tab_place_server("tab_place_ui_1")
