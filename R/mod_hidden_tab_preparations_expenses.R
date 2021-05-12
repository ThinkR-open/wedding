#' hidden_tab_preparations_expenses UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_hidden_tab_preparations_expenses_ui <- function(id){
  
  ns <- NS(id)
  
  tagList(
 
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
    
  )
  
}
    
#' hidden_tab_preparations_expenses Server Functions
#'
#' @noRd 
mod_hidden_tab_preparations_expenses_server <- function(id, r_global = r_global){
  
  moduleServer( id, function(input, output, session){
    
    ns <- session$ns
    
    # Reactives values - local - stay in the module
    r_local <- reactiveValues()
    
    # Clik on real/projected
    observeEvent(input$choice_real_projected, {
      
      # Data filtered
      
      if (input$choice_real_projected == "R\u00e9el") {
        
        r_local$data_expenses_filtered <- r_global$data_expenses %>%
          filter(real_projected == "Real")
        
      } else {
        
        r_local$data_expenses_filtered <- r_global$data_expenses
      }
      
      
    })
    
    # Total expenses
    output$total_expenses <- renderText({
      r_local$data_expenses_filtered %>%
        get_total_expenses(
          suffix_money = " \u20ac",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    # Total paid expenses
    output$total_paid_expenses <- renderText({
      r_local$data_expenses_filtered %>%
        filter(paid_pending == "Paid") %>%
        get_total_expenses(
          suffix_money = " \u20ac",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    # Total pending expenses
    output$total_pending_expenses <- renderText({
      r_local$data_expenses_filtered %>%
        filter(is.na(paid_pending) | paid_pending == "Pending") %>%
        get_total_expenses(
          suffix_money = " \u20ac",
          prefix_money = "",
          big_mark_money = " "
        )
      
    })
    
    # Plot by paymaster
    output$plot_total_by_paymaster <- renderPlot({
      r_global$data_expenses %>%
        plot_expenses_by_paymaster(
          suffix_money = " euros",
          prefix_money = "",
          big_mark_money = " ",
          font_family = "Old Script"
        )
      
    })
    
    # Table
    output$table_expenses <- DT::renderDataTable({
      
      r_local$data_expenses_filtered %>%
        rename_expenses_to_fr()
      
    })
 
  })
  
}
    
## To be copied in the UI
# mod_hidden_tab_preparations_expenses_ui("hidden_tab_preparations_expenses_ui_1")
    
## To be copied in the server
# mod_hidden_tab_preparations_expenses_server("hidden_tab_preparations_expenses_ui_1")
