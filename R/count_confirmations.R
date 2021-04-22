#' Count confirmations or non-confirmations
#'
#' @param filter_confirmation Character vectors. Conditions to be combined with a &
#' @param data_guests Tibble.
#'
#' @importFrom glue glue_collapse
#' @importFrom dplyr filter count pull
#' 
#' @return Character.
#' @export
#'
#' @examples
#' data(data_guests_example)
#' count_confirmations(filter_confirmation = c("type  == 'Teen'",
#'                                             "(here_cocktail == 'No' | 
#'                                               here_diner == 'No' | 
#'                                               here_sunday == 'No')"),
#'                     data_guests = data_guests_example)
count_confirmations <- function(filter_confirmation, data_guests) {
  
  conditions <- glue_collapse(filter_confirmation, sep = " & ")
  
  data_guests %>% 
    filter(eval(parse(text = conditions))) %>% 
    count() %>% 
    pull() %>% 
    as.character()
  
}