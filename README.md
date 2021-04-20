
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wedding <img src="man/figures/logo.png" align="right" alt="" width="120" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/ThinkR-open/wedding/workflows/R-CMD-check/badge.svg)](https://github.com/ThinkR-open/wedding/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

{wedding} helps you to prepare and manage your wedding 👰👰 - 👰🤵 - 🤵🤵

> Your wedding may be postponed several times because of the covid, but
> at least it will have its Shiny app.

## Demo

An example of the app is available here:
<http://connect.thinkr.fr/wedding/>

Login to access the app: *welcome* <br /> Password to access the app:
*bigday* <br /> Password to access the tab dedicated to brides/grooms:
*onlyforbride*

<img src="man/figures/home-page.png" width="100%" />

## Highlights 

- Secure access via a login and password authentication system 
- Information about the wedding day (schedule, accomodation, etc.)
- RSVP feature where guests can specify their presence at the different times of the wedding, their choice for the diner menu and their diet
- Dashboard _- only accessible with login and password -_ where bride/grooms can manage the preparations for their wedding (guests, expenses, table plan)
- Data stored in Google sheets
- Design in line with the wedding announcement (colors, fonts, etc.) 

## Data

The application is based on two datasets stored on Google Drive:

  - *data\_guests*: contains information about your guests (name,
    attendance at the vin d’honneur, attendance at the dinner,
    attendance at the return on Sunday lunch, special diet, etc.)
  - *data\_expenses*: contains information about the wedding expenses
    (venue, caterer, groom’s outfit, wedding rings, etc.)

The datasets are updated according to the user’s navigation in the app.

## Install & launch the demo

You can install the development version of {wedding} from GitHub:

``` r
# install.packages("remotes")
remotes::install_github("ThinkR-open/wedding")
```

To launch the demo version, you will need to create a token to access
the sample data stored on Google Drive:

``` r
# install.packages(c("gargle", "googledrive"))
Sys.setenv(GOOGLE_MAIL = "wedding.r.package@gmail.com") # then restart R
options(gargle_oauth_cache = ".secrets")
options(gargle_quiet = FALSE)
googledrive::drive_auth(cache = ".secrets", 
                        email = Sys.getenv("GOOGLE_MAIL"))
```

Then run the app:

``` r
wedding::run_app()
```
