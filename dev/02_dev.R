# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
###################################
#### CURRENT FILE: DEV SCRIPT #####
###################################


## CSS files ----
golem::add_css_file("custom_app_style")                       # style of the global app
golem::add_css_file("custom_logging_style")                   # style of the logging page
# fonts are stored in www/

## Add modules ----
## Create a module infrastructure in R/
golem::add_module(name = "tab_couple")                        # home tab with counts of days since the meeting and days until wedding day
golem::add_module(name = "tab_confirmation")                  # tab in which the guests come to confirm their coming to the wedding
golem::add_module(name = "tab_schedule")                      # tab with the program of the day
golem::add_module(name = "tab_place")                         # tab with a description of the wedding place
golem::add_module(name = "tab_accommodation")                 # tab with a presentation of the nearby accommodations
golem::add_module(name = "tab_witnesses")                     # tab with information about the witnesses
golem::add_module(name = "tab_covid")                         # tab with information on health restrictions related to covid
golem::add_module(name = "hidden_tab_preparations")           # tab accessible to the bride and groom only to manage the wedding preparations (budget, etc.)
golem::add_module(name = "hidden_tab_preparations_expenses")  # subtab with budget
golem::add_module(name = "hidden_tab_preparations_guests")    # subtab with guests answers to RSVP
golem::add_module(name = "hidden_tab_preparations_menus")     # subtab with guests answers to RSVP
golem::add_module(name = "hidden_tab_preparations_tables")    # subtab with guests answers to RSVP

## Vignette ----
usethis::use_vignette("r_functions_used_in_app")    # vignette with all functions used in the app
devtools::build_vignettes()


## Pipe ----
usethis::use_pipe()

## R files ----
## Functions
usethis::use_r("get_count_countdown_moments")
usethis::use_r("get_map_wedding")
usethis::use_r("rename_expenses_to_fr")
usethis::use_r("get_total_expenses")
usethis::use_r("plot_expenses_by_paymaster")
usethis::use_r("add_info_guests_in_database")
usethis::use_r("count_confirmations")
## Add zzz.R with global variables
usethis::use_r("zzz")
## Add doc data
usethis::use_r("doc_data")


## Tests ----
usethis::use_testthat()
usethis::use_test("get_count_countdown_moments")
usethis::use_test("get_map_wedding_place")
usethis::use_test("rename_expenses_to_fr")
usethis::use_test("get_total_expenses")
usethis::use_test("plot_expenses_by_paymaster")
usethis::use_test("add_info_guests_in_database")
usethis::use_test("count_confirmations")


## Ignore files ----
## Git ignore
usethis::use_git_ignore(".Renviron")
usethis::use_git_ignore("rsconnect/")

## Build ignore
usethis::use_build_ignore(".Renviron")
usethis::use_build_ignore("README.Rmd")
usethis::use_build_ignore("dev/")

## Configure auth to googledrive ----
options(gargle_oauth_cache = ".secrets")
usethis::use_git_ignore(".secrets")
options(gargle_quiet = FALSE)
googledrive::drive_auth(cache = ".secrets", 
                        email = Sys.getenv("GOOGLE_MAIL"))


## GitHub Actions ----
# Chose one of the three
# See https://usethis.r-lib.org/reference/use_github_action.html
usethis::use_github_action_check_standard() 
# Add action for PR
usethis::use_github_action_pr_commands()


## Code Coverage----
# usethis::use_coverage(type = "codecov")     # Set the code coverage service ("codecov" or "coveralls")
# covrpage::covrpage()        # Create a summary readme for the testthat subdirectory


# You're now set! ----
# go to dev/03_deploy.R
rstudioapi::navigateToFile("dev/03_deploy.R")

