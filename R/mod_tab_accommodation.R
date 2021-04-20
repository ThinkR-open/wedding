#' tab_accommodation UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom tibble tibble
mod_tab_accommodation_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
    
    leafletOutput(
      outputId = ns("carte_hebergements")
    ),
    
    tags$br(style = "line-height: 80px"),
    
    fluidRow(
      
      column(
        width = 4, 
        tags$p("Manoir de Belle-No\u00eb", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 25px; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("\u00c0 0 km, 0 minutes", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Chambres d\'h\u00f4tes & gites", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Capacit\u00e9 : 40/42 personnes", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 25 euros par nuit par personne", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("La priorit\u00e9 sera donn\u00e9e \u00e0 nos copains qui picolent beaucoup (ah ah) et aux familles.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Espace camping", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Capacit\u00e9 : illimit\u00e9, plus on est de fous plus on rit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Prix : gratos", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$p("Des toilettes s\u00e8ches sont pr\u00e9sentes sur l\'espace camping.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
        ),
      
      column(
        width = 4,
        align = "center",
        tags$p("Domaine des Ormes", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 25px; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("\u00c0 8 km, 7 minutes", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$a("Site internet", href = "https://www.lesormes.com/fr", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center;"),
        tags$br(style = "line-height: 20px"),
        tags$br(style = "line-height: 20px"),
        tags$p("G\u00eetes 6 personnes", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 472 euros par nuit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Cabanes 2 personnes", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 140 euros par nuit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Cabanes 5 personnes", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 266 euros par nuit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Mobilhomes 6 personnes", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 326 euros par nuit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Cottages 6 personnes", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 398 euros par nuit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Cottages 8 personnes", style = "font-family: \'MrsEavesItalic\'; font-weight: bold; letter-spacing:3px; text-align: center"),
        tags$p("Prix : 470 euros par nuit", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
      ),
      
      column(
        width = 4, 
        tags$p("H\u00f4tels & chambres d\'h\u00f4tes \u00e0 Dol-de-Bretagne", style = "font-family: \'Bauer Bodoni Std 1\'; font-size: 25px; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("\u00c0 4 km, 5 minutes", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center"),
        tags$br(style = "line-height: 20px"),
        tags$p("Vous trouverez de tout au niveau budget, types d\'h\u00e9bergements, etc.", style = "font-family: \'MrsEavesItalic\'; letter-spacing:3px; text-align: center")
      )
    )

  )
}
    
#' tab_accommodation Server Functions
#'
#' @noRd 
mod_tab_accommodation_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
 
    data_hebergements <- tibble(
      name = c(
        "<b>Manoir de Belle-No\u00eb</b><br/>0 km 0 minutes", 
        "<b>Domaine des Ormes</b><br/>8 km 7 minutes", 
        "<b>H\u00f4tels & chambres d\'h\u00f4tes \u00e0 Dol-de-Bretagne</b><br/>4 km 5 minutes"), 
      longitude = c(-1.7129955029636943, -1.73221750178322,  -1.7487624196891016),
      
    )
    
    output$carte_hebergements <- renderLeaflet({
      
      data_markers_accomodation <- tibble(
        longitude = c(-1.7129955029636943, -1.73221750178322,  -1.7487624196891016),
        latitude = c(48.53024518235586, 48.488157127874516, 48.54598088189248),
        name = c(
          "<b>Manoir de Belle-No\u00eb</b><br/>0 km 0 minutes", 
          "<b>Domaine des Ormes</b><br/>8 km 7 minutes", 
          "<b>H\u00f4tels & chambres d\'h\u00f4tes \u00e0 Dol-de-Bretagne</b><br/>4 km 5 minutes")
      )
        
      get_map_wedding(
        data_markers = data_markers_accomodation,
        icon_markers = "home", 
        zoom = 12
      )

    })
    
  })
}
    
## To be copied in the UI
# mod_tab_accommodation_ui("tab_accommodation_ui_1")
    
## To be copied in the server
# mod_tab_accommodation_server("tab_accommodation_ui_1")
