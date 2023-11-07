#' Run the Shiny Application
#'
#' @param ... arguments to pass to golem_opts
#' @inheritParams shiny::shinyApp
#'
#' @export
#' @importFrom shiny shinyApp
#' @importFrom golem with_golem_options
run_app <- function(
  onStart = NULL,
  options = list(), 
  enableBookmarking = NULL,
  ...
) {
  with_golem_options(
    app = shinyApp(
      ui = shinymanager::secure_app(
        ui = app_ui, 
        head_auth = golem_add_external_resources(),
        background  = glue::glue("url(\'www/", Sys.getenv("IMG_BACKGROUND"), "\') no-repeat center top fixed;")
        ),
      server = app_server,
      onStart = onStart,
      options = options, 
      enableBookmarking = enableBookmarking
    ), 
    golem_opts = list(...)
  )
}
