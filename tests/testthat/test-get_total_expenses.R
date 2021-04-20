test_that("get_total_expenses works", {
  
  # Test 1
  test_1 <- tibble(
    amount = c(100, 284, 384)
  )
  
  expect_equal(test_1 %>% get_total_expenses(), 
               "$768")
  
  expect_equal(test_1 %>% get_total_expenses(suffix_money = " \u20ac", prefix_money = "", big_mark_money = " "), 
               "768 \u20ac")
  
  # Test 2
  test_2 <- tibble(
    amount = c(NA, 284, 384, 1000)
  )
  
  expect_equal(test_2 %>% get_total_expenses(), 
               "$1,668")
  
  expect_equal(test_2 %>% get_total_expenses(suffix_money = " \u20ac", prefix_money = "", big_mark_money = " "), 
               "1 668 \u20ac")
  
})
