test_that("get_count_countdown_moments works", {
  
  # Test 1
  test_1 <- get_count_countdown_moments(start_moment = "2009-10-14 04:00:00",
                                        end_moment = "2021-10-02 15:00:00",
                                        text = "between the moment they met and the wedding",
                                        language = "fr")
  
  expect_equal(as.character(test_1), 
               "4371 j. 11 h. 0 m. 0 s. between the moment they met and the wedding")
  
  # Test 2
  test_2 <- get_count_countdown_moments(start_moment = "1998-07-12 21:00:00",
                                        end_moment = "2021-04-09 11:00:00",
                                        text = "beetwen worldcup 1998 and 2021-04-09 11 am")
  
  expect_equal(as.character(test_2), 
               "8306 d. 14 h. 0 m. 0 s. beetwen worldcup 1998 and 2021-04-09 11 am")
  
})
