test_that("count_confirmations works", {
  
  extract_data_guests <- tibble::tibble(
    type = c("Adult", "Teen", "Kid", "Adult", "Adult", "Adult", "Kid", "Teen"),
    here_cocktail = c(rep("Yes", 5), rep("No", 3)),
    here_diner = c(rep("Yes", 4), rep("No", 3), NA_character_),
    here_sunday = c(rep("Yes", 3), rep("No", 4), NA_character_)
  )
    
  expect_equal(count_confirmations(filter_confirmation = c("type == 'Adult'", "here_cocktail == 'Yes'"), data_guests = extract_data_guests), 
               "3")
  
  expect_equal(count_confirmations(filter_confirmation = c("type == 'Adult'", "(here_cocktail == 'Yes' | here_diner == 'Yes' | here_sunday == 'Yes')"), data_guests = extract_data_guests), 
               "3")
  
  expect_equal(count_confirmations(filter_confirmation = c("type == 'Teen'", "here_diner == 'Yes'"), data_guests = extract_data_guests), 
               "1")
  
})
