## code to prepare `my_dataset` dataset goes here

## data_expenses_example
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

## data_guests_example
data_guests_example <- tibble(
  name = c("David", "Margot", "Pierre", "Marie"),
  type = c("Adult", "Adult", "Kid", "Teen"),
  table = c(1, 1, 2, 2),
  announcement = c("Yes", NA_character_, "Yes", NA_character_),
  here_cocktail = c(rep(NA_character_, 3), "No"),
  here_diner = c("Oui", "Oui", "Oui", "No"),
  here_sunday = c(rep(NA_character_, 3), "No"),
  special_diet = c(rep(NA_character_, 4)), 
  menu_diner = c(rep(NA_character_, 4)),
  time_confirmation = c(rep(NA_character_, 3), "2021-01-22 07:28:14 CEST")
  )
usethis::use_data(data_guests_example, overwrite = TRUE)

## data_guests_table_example
data_guests_table_example <- tibble(
  name = c("David", "Margot", "Isaure", "Ang\u00e8le", "Charlotte", "Maxence", "Claude", "Marie-Anne", "Eug\u00e9nie", "Lou", 
           "Madeleine", "Roger", 
           "Anne-Lise", "Mickael", "Robert"), 
  table = c(rep(1, 10), rep(10, 2), rep(2, 3)), 
  here_diner = rep("Oui", 15)
)
usethis::use_data(data_guests_table_example, overwrite = TRUE)

