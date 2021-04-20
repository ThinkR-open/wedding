test_that("rename_expenses_to_fr works", {
  
  # Test 1
  test_1 <- tibble(
    object = sample(x = 1: 10, size = 20, replace = TRUE),
    real_projected = c(rep("Real", 10), rep("Projected", 10)),
    paid_pending = c(rep("Paid", 10), NA, rep("Pending", 9)),
    description = sample(x = 1: 10, size = 20, replace = TRUE),
    society = sample(x = 1: 10, size = 20, replace = TRUE),
    paymaster = sample(x = 1: 10, size = 20, replace = TRUE),
    amount =  sample(x = 1: 10, size = 20, replace = TRUE)
  )
  
  expect_equal(test_1 %>% rename_expenses_to_fr() %>% names(),
               c("Poste de dépense", "Réel ou prévisionnel", "Payé ou en attente", 
                 "Description", "Destinataire", "Payeur", "Montant"))
  
  expect_equal(test_1 %>% rename_expenses_to_fr() %>% select("Réel ou prévisionnel") %>% pull(),
               c("Réel", "Réel", "Réel", "Réel", "Réel", "Réel", "Réel", 
                 "Réel", "Réel", "Réel", "Prévisionnel", "Prévisionnel", 
                 "Prévisionnel", "Prévisionnel", "Prévisionnel", "Prévisionnel", 
                 "Prévisionnel", "Prévisionnel", "Prévisionnel", "Prévisionnel"))
  
  expect_equal(test_1 %>% rename_expenses_to_fr() %>% select("Payé ou en attente") %>% pull(),
               c("Payé", "Payé", "Payé", "Payé", "Payé", "Payé", "Payé", 
                 "Payé", "Payé", "Payé", NA, "En attente", "En attente", 
                 "En attente", "En attente", "En attente", "En attente", "En attente", 
                 "En attente", "En attente"))
  
  # Test 1
  test_2 <- tibble(
    random = sample(x = 1: 10, size = 20, replace = TRUE),
    real_projected = sample(x = 1: 10, size = 20, replace = TRUE),
    paid_pending = sample(x = 1: 10, size = 20, replace = TRUE),
    description = sample(x = 1: 10, size = 20, replace = TRUE),
    nothing = sample(x = 1: 10, size = 20, replace = TRUE),
    paymaster = sample(x = 1: 10, size = 20, replace = TRUE),
    amount =  sample(x = 1: 10, size = 20, replace = TRUE)
  )
  
  expect_error(test_2 %>% rename_expenses_to_fr() %>% names())
  
})
