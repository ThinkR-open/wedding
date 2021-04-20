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
          "Mot de passe :"
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
    
    # Password pour accéder à cette page + RenderUI
    observeEvent(input$password_tab_preparation, {
      
      if (input$password_tab_preparation == Sys.getenv("PWD_COUPLE")) {
        
        output$show_tab_preparation <- renderUI({
          
          tagList(tabsetPanel(
            type = "tabs",
            
            tabPanel(
              "D\u00e9penses",
              
              tags$br(style = "line-height: 20px"),
              
              sidebarLayout(
                sidebarPanel(
                  selectInput(
                    inputId = ns("choice_real_projected"),
                    label = "Choisir les d\u00e9penses r\u00e9elles et/ou pr\u00e9visionnelles",
                    choices = c("R\u00e9el", "R\u00e9el + Pr\u00e9visionnel"),
                    selected = "Pr\u00e9visionnel"
                  )
                  
                ),
                
                mainPanel(
                  h1("Total des d\u00e9penses"),
                  textOutput(outputId = ns("total_expenses")),
                  
                  fluidRow(
                    column(
                      width = 6,
                      h4("D\u00e9j\u00e0 pay\u00e9es"),
                      textOutput(outputId = ns("total_paid_expenses"))
                    ),
                    column(width = 6,
                           h4("En attente"),
                           textOutput(
                             outputId = ns("total_pending_expenses")
                           ))
                  ),
                  
                  tags$br(style = "line-height: 20px"),
                  
                  h1("Liste des d\u00e9penses"),
                  DT::dataTableOutput(outputId = ns("table_expenses")),
                  
                  tags$br(style = "line-height: 20px"),
                  
                  h1("R\u00e9partition par payeur"),
                  plotOutput(outputId = ns("plot_total_by_paymaster"))
                  
                )
              )
            ),
            
            tabPanel("Invit\u00e9s",
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
                     )),
            
            tabPanel("Informations pour les menus",
                     tags$br(style = "line-height: 20px"),
                     fluidRow(
                       align = "center",
                       column(
                         width = 4,
                         style = "border-right:1px solid",
                         h1("Vin d\'honneur"),
                         fluidRow(
                           column(width = 6,
                                  h4("Portions adultes"),
                                  textOutput(ns("number_adults_menu_cocktail"))),
                           column(width = 6,
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
                                  h4("Enfants"),
                                  textOutput(ns("number_kids_menu_sunday")))
                         )
                       )
                       
                     ),
                     
                     tags$br(style = "line-height: 20px"),
                     
                     fluidRow(
                       align = "center",
                       DT::dataTableOutput(ns("table_menus_diets"), width = "70%")
                     )
                       
                     ),
            
            tabPanel("Plan de table",
                     tags$br(style = "line-height: 20px"))
            
          ))
          
        })
        
      }
    })
    
    # Reactives values
    r_local <- reactiveValues()

    observeEvent(input$choice_real_projected, {
      
      # Data filtered
      
      if (input$choice_real_projected == "R\u00e9el") {
        
        r_local$data_expenses_filtered <- r_global$data_expenses %>%
          filter(real_projected == "Real")
        
      } else {
        
        r_local$data_expenses_filtered <- r_global$data_expenses
      }
      
      
    })
    
    output$total_expenses <- renderText({
      r_local$data_expenses_filtered %>%
        get_total_expenses(
          suffix_money = " \u20ac",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    output$total_paid_expenses <- renderText({
      r_local$data_expenses_filtered %>%
        filter(paid_pending == "Paid") %>%
        get_total_expenses(
          suffix_money = " \u20ac",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    output$total_pending_expenses <- renderText({
      r_local$data_expenses_filtered %>%
        filter(is.na(paid_pending) | paid_pending == "Pending") %>%
        get_total_expenses(
          suffix_money = " \u20ac",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    output$plot_total_by_paymaster <- renderPlot({
      r_global$data_expenses %>%
        plot_expenses_by_paymaster(
          suffix_money = " euros",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    output$table_expenses <- DT::renderDataTable({
      r_local$data_expenses_filtered %>%
        rename_expenses_to_fr()
      
    })
    
    output$number_confirmations <- renderText({
      
      r_global$data_guests %>% 
        filter(here_cocktail == "Oui" | here_diner == "Oui" | here_sunday == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()    
      
    })
    
    output$number_adults <- renderText({
      
      r_global$data_guests %>% 
        filter(type == "Adulte") %>% 
        filter(here_cocktail == "Oui" | here_diner == "Oui" | here_sunday == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_teenagers <- renderText({
      
      r_global$data_guests %>% 
        filter(type == "Ado") %>% 
        filter(here_cocktail == "Oui" | here_diner == "Oui" | here_sunday == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_kids <- renderText({
      
      r_global$data_guests %>% 
        filter(type == "Enfant") %>% 
        filter(here_cocktail == "Oui" | here_diner == "Oui" | here_sunday == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_announcements <- renderText({
      
      r_global$data_guests %>% 
        filter(announcement == "Yes") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$list_guest <- DT::renderDataTable({
      
      r_global$data_guests %>% 
        select(name, type, here_cocktail, here_diner, here_sunday) %>% 
        rename("Nom" = name, 
               "Cat\u00e9gorie" = type,
               "Pr\u00e9sence vin d\'honneur" = here_cocktail,
               "Pr\u00e9sence d\u00eener" = here_diner, 
               "Pr\u00e9sence retour" = here_sunday)
      
    })
    
    output$number_adults_menu_cocktail <- renderText({
      
      r_global$data_guests %>% 
        filter((type == "Adulte" | type == "Ado") & here_cocktail == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_kids_menu_cocktail <- renderText({
      
      r_global$data_guests %>% 
        filter(type == "Enfant" & here_cocktail == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_adults_menu_diner <- renderText({
      
      r_global$data_guests %>% 
        filter(menu_diner == "Menu adulte") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_service_provider_menu_diner <- renderText({
      
      "5"
      
    })
    
    output$number_kids_menu_diner <- renderText({
      
      r_global$data_guests %>% 
        filter(menu_diner == "Menu enfant") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_adults_menu_sunday <- renderText({
      
      r_global$data_guests %>% 
        filter((type == "Adulte" | type == "Ado") & here_sunday == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$number_kids_menu_sunday <- renderText({
      
      r_global$data_guests %>% 
        filter(type == "Enfant" & here_sunday == "Oui") %>% 
        count() %>% 
        pull() %>% 
        as.character()
      
    })
    
    output$table_menus_diets <- DT::renderDataTable({
      
      r_global$data_guests %>% 
        select(name, special_diet, here_cocktail, here_diner, menu_diner, here_sunday) %>% 
        rename("Nom" = name, 
               "R\u00e9gime sp\u00e9cial" = special_diet,
               "Pr\u00e9sence vin d\'honneur" = here_cocktail,
               "Pr\u00e9sence d\u00eener" = here_diner, 
               "Menu pour le d\u00eener" = menu_diner,
               "Pr\u00e9sence retour" = here_sunday
               )
      
    })
  })
  
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_ui("hidden_tab_preparations_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_server("hidden_tab_preparations_ui_1")
