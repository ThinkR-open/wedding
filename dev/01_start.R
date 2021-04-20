# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
########################################
#### CURRENT FILE: ON START SCRIPT #####
########################################

## Fill the DESCRIPTION ----
## Add meta data about your application
## 
## /!\ Note: if you want to change the name of your app during development, 
## either re-run this function, call golem::set_golem_name(), or don't forget
## to change the name in the app_sys() function in app_config.R /!\
## 
golem::fill_desc(
  pkg_name = "wedding",                                           # The Name of the package containing the App 
  pkg_title = "App for Margot and David weeding",                  # The Title of the package containing the App 
  pkg_description = "App for Margot and David weeding. 
  Contains all the information relative to the wedding.",          # The Description of the package containing the App 
  author_first_name = "Margot",                                    # Your First Name
  author_last_name = "Brard",                                      # Your Last Name
  author_email = "margot@thinkr.fr",                               # Your Email
  repo_url = NULL                                                  # The URL of the GitHub Repo (optional) 
)     

## Set {golem} options ----
golem::set_golem_options()

## Create Common Files ----
## See ?usethis for more information
usethis::use_gpl_license()                                         # License
usethis::use_readme_rmd(open = FALSE)                              # Create README
usethis::use_code_of_conduct()                                     # Create code of conduct
usethis::use_lifecycle_badge( "Experimental" )                     # Create experimental lifecycle badge
usethis::use_news_md(open = FALSE)                                 # Create news file      

## Use git ----
usethis::use_git()
usethis::git_vaccinate()                                           # Ignore MacOS files 

## Init Testing Infrastructure ----
## Create a template for tests
golem::use_recommended_tests()

## Use Recommended Packages ----
golem::use_recommended_deps()

## Favicon ----
# If you want to change the favicon (default is golem's one)
golem::use_favicon(path = "inst/app/www/button_grey_heart.ico")     # path = "path/to/ico"

# You're now set! ----

# go to dev/02_dev.R
rstudioapi::navigateToFile( "dev/02_dev.R" )

