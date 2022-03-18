#' Add information about guests in the database
#'
#' @param info_to_add Tibble. Information to be added.
#' @param data_guests Tibble. Initial table.
#'
#' @importFrom dplyr distinct pull filter select left_join bind_rows arrange
#' 
#' @return Tibble.
#' @export
#'
#' @examples
#' info_to_add_in_data_guests <- tibble::tibble(
#'   name = c("David", "Margot"),
#'   here_cocktail = rep("Yes", 2),
#'   here_diner = rep("Yes", 2),
#'   here_sunday = rep("Yes", 2),
#'   special_diet = c(NA_character_, "I am vegan"),
#'   menu_diner = rep("Adult", 2),
#'   time_confirmation = rep("2021-04-22 09:57:12 CEST", 2)
#'   )
#' 
#' data(data_guests_example)
#' 
#' add_info_guests_in_database(info_to_add = info_to_add_in_data_guests, 
#'                             data_guests = data_guests_example)
add_info_guests_in_database <- function(info_to_add, data_guests) {
  
  names_guests_to_add <- info_to_add %>% 
    distinct(name) %>% 
    pull(name)
  
  if (Sys.getenv("USE_PREFILLED_DATA_GUEST") == "no") {
    
    data_guests_to_add <- info_to_add
      
    new_data_guests <- data_guests %>% 
      bind_rows(data_guests_to_add) %>% 
      arrange(table)
    
  } else {
    
    data_guests_to_add  <- data_guests %>% 
      filter(name %in% names_guests_to_add) %>% 
      select(name, type, table, announcement) %>% 
      left_join(info_to_add,
                by = "name")
    
    new_data_guests <- data_guests %>% 
      filter(!(name %in% names_guests_to_add)) %>% 
      bind_rows(data_guests_to_add) %>% 
      arrange(table)
  }
  
  return(new_data_guests)
  
}
