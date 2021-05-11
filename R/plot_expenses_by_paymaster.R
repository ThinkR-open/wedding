#' Plot expenses by paymaster
#'
#' @param .data Tibble.
#' @param prefix_money Character.
#' @param suffix_money Character.
#' @param big_mark_money Character.
#' @param font_family Character.
#'
#' @return Plot.
#' @export
#' 
#' @importFrom scales dollar_format dollar
#' @importFrom ggplot2 ggplot aes geom_col labs geom_text scale_y_continuous theme_minimal theme element_text
#' @importFrom dplyr filter group_by summarise mutate
#' 
#' @examples
#' data(data_expenses_example)
#' data_expenses_example %>% 
#'   plot_expenses_by_paymaster()
plot_expenses_by_paymaster <- function(.data, prefix_money = "$", suffix_money = "", big_mark_money = ",", font_family = "Times") {
  
  plot_expenses <- .data %>% 
    filter(paid_pending == "Paid") %>%
    group_by(paymaster) %>%
    summarise(amount = sum(amount, na.rm = TRUE)) %>% 
    mutate(total_amount = sum(amount, na.rm = TRUE),
           prop_amount = round(amount / total_amount * 100),
           label = paste(dollar(amount, suffix = suffix_money, prefix = prefix_money, big.mark = big_mark_money), "-", prop_amount, "%")) %>% 
    ggplot() +
    aes(x = paymaster, y = amount) +
    geom_col(fill = "black") +
    labs(
      x = "",
      y = ""
    ) +
    geom_text(aes(label = label), vjust = -0.5, family = font_family, size = 6) +
    scale_y_continuous(labels = dollar_format(suffix = suffix_money, prefix = prefix_money, big.mark = big_mark_money)) +
    theme_minimal() +
    theme(title = element_text(family = font_family),
          text = element_text(family = font_family),
          axis.text.x = element_text(family = font_family, size = 20))

  return(plot_expenses)
  
}