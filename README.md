
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wedding <img src="man/figures/logo.png" align="right" alt="" width="120" />

<!-- badges: start -->

[![R-CMD-check](https://github.com/ThinkR-open/wedding/workflows/R-CMD-check/badge.svg)](https://github.com/ThinkR-open/wedding/actions)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

{wedding} helps you to prepare and manage your wedding 👰👰 - 👰🤵 - 🤵🤵

> Your wedding may be postponed several times because of the covid, but
> at least it will have its Shiny app. \#\# Demo

An example of the app is available here:
<http://connect.thinkr.fr/wedding/>

Login to access the app: *welcome* <br /> Password to access the app:
*bigday* <br /> Password to access the tab dedicated to brides/grooms:
*onlyforbride*

<img src="man/figures/home-page.png" width="100%" />

## Meaning of the tabs

  - *Accueil*: Home
  - *Confirmer ma venue*: Confirm my presence
  - *Programme de la journée*: Program of the day
  - *Lieu du mariage*: Location of the wedding
  - *Hébergements*: Accommodations
  - *Témoins*: Witnesses
  - *Covid*: Covid rules
  - *Espace des mariés*: Groom’s area (expenses, guests, menu, seating
    plan)

## Data

The application is based on two datasets stored on Google Drive:

  - **data\_guests**: contains information about your guests (name,
    attendance at the vin d’honneur, attendance at the dinner,
    attendance at the return on Sunday lunch, special diet, etc.)
  - **data\_expenses**: contains information about the wedding expenses
    (venue, caterer, groom’s outfit, wedding rings,
etc.)

<img src="man/figures/data-examples.png" width="70%" style="display: block; margin: auto;" />

Structure of the datasets can be explored with:

``` r
# Install and load {wedding} package
# install.packages("remotes")
remotes::install_github("ThinkR-open/wedding")
library(wedding)

# View data_expenses
data("data_expenses_example")
data_expenses_example

# View data_guests
data("data_guests_example")
data_guests_example
```

The datasets will be updated according to the user’s navigation in the
app.

If you want to use others data, you will have to store these two kinds
of datasets on your Google Drive account. Then, you will have to create
and store a token to access the data stored on your account:

``` r
# Install {gargle} and {googledrive} packages
# install.packages(c("gargle", "googledrive"))

# Replace wedding.r.package@gmail.com by your gmail adress
Sys.setenv(GOOGLE_MAIL = "wedding.r.package@gmail.com")

# Then restart R and run
options(gargle_oauth_cache = ".secrets")
options(gargle_quiet = FALSE)
googledrive::drive_auth(cache = ".secrets", 
                        email = Sys.getenv("GOOGLE_MAIL"))
# A popup will open, and you will be asked to write your password
# This will create a token and will store it in the .secrets folder
```
