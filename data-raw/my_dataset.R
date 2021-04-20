## code to prepare `my_dataset` dataset goes here

## dta_expenses_example
data_expenses_example <- tibble(
  object = c("hall", "caterer", "hall", "caterer", "dress", "suit", "rings", "flowers", "photo", "DJ"),
  real_projected = c("Real", "Real", "Real", "Real", "Real", "Real", "Projected", "Projected", "Projected", "Projected"),
  paid_pending = c("Paid", "Paid", "Pending", "Pending", "Paid", "Paid", NA, NA, NA, NA),
  description = c(rep("A random description", 10)),
  society = c(rep("A random society", 10)),
  paymaster = c("Isaure", "Isaure", NA, NA, "Isaure", "Ange", NA, NA, NA, NA),
  amount = c(700, 1000, 1700, 5000, 1000, 800, 500, 500, 1000, 1000)
)
usethis::use_data(data_expenses_example, overwrite = TRUE)
