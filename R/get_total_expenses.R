#' Compute the total amount of expenses and convert as character
#'
#' @param .data Tibble.
#' @param prefix_money Character. 
#' @param suffix_money Character. 
#' @param big_mark_money Character. 
#'
#' @return Character.
#' @export
#'
#' @importFrom scales dollar
#' @importFrom dplyr summarise pull
#' 
#' @examples
#' data(data_expenses_example)
#' data_expenses_example %>% 
#'   get_total_expenses()
get_total_expenses <- function(.data, prefix_money = "$", suffix_money = "", big_mark_money = ",") {
  
  .data %>% 
    summarise(sum(amount, na.rm = TRUE)) %>% 
    pull() %>%
    dollar(suffix = suffix_money, prefix = prefix_money, big.mark = big_mark_money)
  
}
