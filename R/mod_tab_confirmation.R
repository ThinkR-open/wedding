#' tab_confirmation UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#' 
#' @importFrom readr read_csv locale
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' @importFrom shinyjs useShinyjs
mod_tab_confirmation_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
    useShinyjs(),
    
    fluidRow(
      align = "center",
      tags$br(style = "line-height: 65px"),
      h1("Confirmer ma venue / notre venue", style = "font-family: \'Bauer Bodoni Std 1\'; font-size:30px; letter-spacing:5px; color: black; text-align: center"),
      h1("Merci d\'indiquer la pr\u00e9sence de chaque personne, y compris celle des enfants", style = "font-family: \'Bauer Bodoni Std 1\'; font-size:15px; letter-spacing:2px; color: black; text-align: center"),
      tags$br(style = "line-height: 40px"),
    ),
    
    sidebarLayout(
      
      sidebarPanel(
        
        width = 5,
        
        selectInput(
          inputId = ns("name"),
          label = "Pr\u00e9nom",
          choices = c("Choisir dans la liste la personne", letters),
          selected = "Choisir dans la liste la personne"
        ),

        tags$br(style = "line-height: 20px"),
        
        tags$p("Pr\u00e9sence aux diff\u00e9rents moments du mariage", style = "font-size:15px; letter-spacing:3px; font-weight: bold; color: black"),
         
        fluidRow(
          column(
            width = 4,
            selectInput(
              inputId = ns("here_cocktail"),
              label = "Vin d\'honneur",
              choices = c("", "Oui", "Non"),
              selected = ""
            )
          ),
          column(
            width = 4,
            selectInput(
              inputId = ns("here_diner"),
              label = "D\u00eener",
              choices = c("", "Oui", "Non"),
              selected = ""
            )
          ),
          column(
            width = 4,
            selectInput(
              inputId = ns("here_sunday"),
              label = "Retour",
              choices = c("", "Oui", "Non"),
              selected = ""
            )
          )
        ),
        
        tags$br(style = "line-height: 20px"),
        
        textInput(
          inputId = ns("special_diet"),
          label = "R\u00e9gime alimentaire particulier (allergies/intol\u00e9rances alimentaires, r\u00e9gime femme enceinte, etc.)",
          placeholder = "Indiquer ici les r\u00e9gimes"
        ),
        
        uiOutput(ns("show_input_teens_menu")),
      
        uiOutput(ns("show_input_kids_menu")),
        
        tags$br(style = "line-height: 20px"),
        
        actionButton(
          inputId = ns("save_info_guest"),
          label = "Enregistrer mes choix pour cette personne *"
        ),
        
        tags$br(style = "line-height: 20px"),
        
        tags$p("* Vous pourrez r\u00e9aliser de nouveau l\'op\u00e9ration pour ajouter une nouvelle personne", style = "font-size:15px; letter-spacing:3px; color: black"),
        
      ),
      
      mainPanel(
        
        width = 7,
        
        h1("R\u00e9capitulatif de vos informations", style = "font-size:20px"),
        
        tags$br(style = "line-height: 20px"),
        
        tableOutput(ns("summary_info_guest")),
        
        tags$br(style = "line-height: 20px"),
        
        fluidRow(
          align = "center",
          column(
            width = 6,
            actionButton(
              inputId = ns("clean_last_info_guest"),
              label = "Supprimer les derni\u00e8res informations enregistr\u00e9es"
            )
          ),
          column(
            width = 6,
            actionButton(
              inputId = ns("send_info_guest"),
              label = "Envoyer mes choix aux mari\u00e9s"
            )
          )
        )
        
      )
      
  )
  )
  
}
    
#' tab_confirmation Server Functions
#' 
#' @importFrom shinyjs reset hide
#' @importFrom tibble add_row
#' @importFrom dplyr top_n distinct pull filter left_join arrange bind_rows group_by
#' @importFrom purrr map_dfr
#'
#' @noRd 
mod_tab_confirmation_server <- function(id, r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    # Local reactive values - stay in the module
    r_local <- reactiveValues()
    
    r_local$info <- tibble(name = character(),
                           here_cocktail = character(),
                           here_diner = character(), 
                           here_sunday = character(),
                           special_diet = character(),
                           menu_diner = character(),
                           time_confirmation = as.character())
    
    # Update input list guest according to data
    observeEvent(TRUE, once = TRUE, {
      
      updateSelectInput(
        session = session, 
        inputId = "name", 
        choices = c("Choisir dans la liste la personne", r_global$data_guests %>% distinct(name) %>% pull()),
        selected = "Choisir dans la liste la personne"
        )
      
    })
    
    # Find info about guest in data and update selectinput menu according to guest type adult/teen/kid
    observeEvent(input$name, ignoreInit = TRUE, {

      req(input$name != "Choisir dans la liste la personne")
      req(r_global$data_guests)

      r_local$type_guest <- r_global$data_guests %>%
        filter(name == input$name) %>%
        pull(type)

      if (r_local$type_guest == "Ado") {

        output$show_input_teens_menu <- renderUI({

          selectInput(
            inputId = ns("teens_menu"),
            label = "Menu pour le d\u00eener - le menu adulte contient du foie gras et du canard",
            choices = c("Menu adulte", "Menu enfant"),
            selected = "Menu adulte"
          )
          
        })
        
        shinyjs::hide(id = "kids_menu")

      } else if (r_local$type_guest == "Enfant") {

        output$show_input_kids_menu <- renderUI({

          selectInput(
            inputId = ns("kids_menu"),
            label = "Choix pour les repas (cocktail, d\u00eener, retour)",
            choices = c("Menu enfant", "Pas de repas \u00e0 pr\u00e9voir pour mon bibou"),
            selected = "Menu enfant"
          )

        })
        
        shinyjs::hide(id = "teens_menu")
        
      } else {
        
        shinyjs::hide(id = "kids_menu")
        shinyjs::hide(id = "teens_menu")
        
      }
      
    })
    
    # Click on save choice / add info to sumamry tibble
    observeEvent(input$save_info_guest, {
      
      r_local$name <- input$name
      r_local$here_cocktail <- input$here_cocktail
      r_local$here_diner <- input$here_diner
      r_local$here_sunday <- input$here_sunday
      r_local$special_diet <- input$special_diet
      
      if (r_local$type_guest == "Adulte") {
        
        r_local$menu_diner <- "Menu adulte"
        
      } else if (r_local$type_guest == "Ado") {
        
        r_local$menu_diner <- input$teens_menu
        
      } else if (r_local$type_guest == "Enfant") {
        
        r_local$menu_diner <- input$kids_menu
        
      }
      
      if (r_local$here_diner == "Non") {
        
        r_local$menu_diner <- NA_character_
        
      }

      r_local$info <- r_local$info %>% 
        add_row(name = r_local$name,
                here_cocktail = r_local$here_cocktail,
                here_diner = r_local$here_diner, 
                here_sunday = r_local$here_sunday,
                special_diet = r_local$special_diet,
                menu_diner = r_local$menu_diner,
                time_confirmation = as.character(Sys.time()))
      
      reset("name")
      reset("here_cocktail")
      reset("here_diner")
      reset("here_sunday")
      reset("special_diet")
      
    })
    
    # Delete last line
    observeEvent(input$clean_last_info_guest, {
      
      n_lines <- nrow(r_local$info)
      r_local$info <- r_local$info %>%
        top_n(n = -(n_lines - 1))
      
    })
    
    # Table summarising info
    output$summary_info_guest <- renderTable({
      
      r_local$info %>% 
        select(-time_confirmation) %>% 
        rename(
          stats::setNames(c("name", "here_cocktail", "here_diner", "here_sunday", "special_diet", "menu_diner"), 
                          c("Nom", "Pr\u00e9sence vin d\'honneur", "Pr\u00e9sence d\u00eener", "Pr\u00e9sence retour", "R\u00e9gime particulier", "Menu pour le d\u00eener") 
          )
        )
      
    })
    
    # Save info
    observeEvent(input$send_info_guest, {
      
      # Verify if info about guests is already in the database
      vec_guests_already_answer <- r_global$data_guests %>% 
        filter(!is.na(here_cocktail) & !is.na(here_diner) & !is.na(here_sunday)) %>% 
        pull(name)
      
      vec_guests_to_send <- r_local$info %>% 
        pull(name)
      
      if (any(vec_guests_to_send %in% vec_guests_already_answer)) {
        
        showNotification(ui = "Les informations de certains invit\u00e9s avaient d\u00e9j\u00e0 \u00e9t\u00e9 envoy\u00e9es aux mari\u00e9s. Elles ont \u00e9t\u00e9 remplac\u00e9es par celles que vous venez de renseigner.",
                         type = "default")
        
      }
      
      # Verify if there are doubles - if yes, delete them
      
      if (any(duplicated(vec_guests_to_send))) {
        
        showNotification(ui = "Vous avez renseign\u00e9 des doublons d\'informations pour la m\u00eame personne. Seules les derni\u00e8res seront conserv\u00e9es.",
                         type = "default")
        
        r_local$info <- r_local$info %>% 
          group_by(name) %>% 
          top_n(1)
        
      }
      
      # Construct the new database
      r_global$data_guests <- add_info_guests_in_database(info_to_add = r_local$info,
                                                          data_guests = r_global$data_guests)
      
      # Show notification
      showNotification(ui = "Vos informations ont bien \u00e9t\u00e9 envoy\u00e9es aux mari\u00e9s.",
                       type = "default")
      
      # Upload the new database
      temp_dir <- tempdir()
      readr::write_csv(r_global$data_guests, glue::glue(temp_dir, "/new_data_guests.csv"))
      googledrive::drive_update("data_guests", glue::glue(temp_dir, "/new_data_guests.csv"))
      
    })
    
  })
}
    
## To be copied in the UI
# mod_tab_confirmation_ui("tab_confirmation_ui_1")
    
## To be copied in the server
# mod_tab_confirmation_server("tab_confirmation_ui_1")
