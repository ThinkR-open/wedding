test_that("add_info_guests_in_database works", {
  
  initial_data_guests <- structure(
    list(
      name = c("David", "Margot", "Pierre", "Marie"),
      type = c("Adult", "Adult", "Kid", "Teen"),
      table = c(1, 1, 2, 2),
      announcement = c("Yes", NA, "Yes", NA),
      here_cocktail = c(NA,
                        NA, NA, "No"),
      here_diner = c(NA, NA, NA, "No"),
      here_sunday = c(NA,
                      NA, NA, "No"),
      special_diet = c(NA_character_, NA_character_,
                       NA_character_, NA_character_),
      menu_diner = c(NA_character_,
                     NA_character_, NA_character_, NA_character_),
      time_confirmation = c(NA,
                            NA, NA, "2021-01-22 07:28:14 CEST")
    ),
    row.names = c(NA,-4L),
    class = c("tbl_df", "tbl", "data.frame")
  )
  
  info_to_add_in_initial_data_guests <-
    structure(
      list(
        name = c("David", "Margot"),
        here_cocktail = c("Yes",
                          "Yes"),
        here_diner = c("Yes", "Yes"),
        here_sunday = c("Yes",
                        "Yes"),
        special_diet = c(NA, "I am vegan"),
        menu_diner = c("Adult",
                       "Adult"),
        time_confirmation = c("2021-04-22 09:57:12 CEST", "2021-04-22 09:57:12 CEST")
      ),
      row.names = c(NA,-2L),
      class = c("tbl_df", "tbl", "data.frame")
    )
  
  withr::with_envvar(c("USE_PREFILLED_DATA_GUEST" = "yes"), {
    expect_equal(
      add_info_guests_in_database(info_to_add = info_to_add_in_initial_data_guests, data_guests = initial_data_guests),
      structure(
        list(
          name = c("David", "Margot", "Pierre", "Marie"),
          type = c("Adult", "Adult", "Kid", "Teen"),
          table = c(1, 1,
                    2, 2),
          announcement = c("Yes", NA, "Yes", NA),
          here_cocktail = c("Yes",
                            "Yes", NA, "No"),
          here_diner = c("Yes", "Yes", NA, "No"),
          here_sunday = c("Yes", "Yes", NA, "No"),
          special_diet = c(NA,
                           "I am vegan", NA, NA),
          menu_diner = c("Adult", "Adult", NA,
                         NA),
          time_confirmation = c(
            "2021-04-22 09:57:12 CEST",
            "2021-04-22 09:57:12 CEST",
            NA,
            "2021-01-22 07:28:14 CEST"
          )
        ),
        row.names = c(NA,-4L),
        class = c("tbl_df",
                  "tbl", "data.frame")
      )
    )
    })
  
})
