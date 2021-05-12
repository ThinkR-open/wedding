#' Plot all seating plans
#'
#' @param .data Tibble.
#' @param font_family_table Character.
#' @param font_family_guests Character.
#'
#' @importFrom dplyr distinct pull
#' @importFrom purrr map
#' @importFrom patchwork wrap_plots
#' 
#' @return patchwork object.
#' @export
#'
#' @examples
#' data(data_guests_table_example)
#' #data_guests_table_example %>% 
#'  #plot_all_seating_plans()
plot_all_seating_plans <- function(.data, font_family_table = "Times", font_family_guests = "Times") {
  
  list_plots_seating_plans <- .data %>% 
    distinct(table) %>% 
    arrange(table) %>% 
    pull(table) %>% 
    map(~ plot_one_seating_plan(id_table = .x, .data = .data, font_family_table = font_family_table, font_family_guests = font_family_guests))
  
  wrap_plots(list_plots_seating_plans)
  
}
