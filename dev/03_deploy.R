# Building a Prod-Ready, Robust Shiny Application.
# 
# README: each step of the dev files is optional, and you don't have to 
# fill every dev scripts before getting started. 
# 01_start.R should be filled at start. 
# 02_dev.R should be used to keep track of your development during the project.
# 03_deploy.R should be used once you need to deploy your app.
# 
# 
######################################
#### CURRENT FILE: DEPLOY SCRIPT #####
######################################

# Test your app

## Run checks ----
## Check the package before sending to prod
attachment::att_amend_desc()
devtools::check()

# Deploy

account_name <- Sys.getenv("NAME_ACCOUNT_RSTUDIO_CONNECT")
account_server <- Sys.getenv("NAME_SERVER_RSTUDIO_CONNECT")
api_connect_key <- Sys.getenv("API_CONNECT_KEY")

rsconnect::connectApiUser(
  account = account_name,
  server = account_server,
  apiKey = api_connect_key
)

rsconnect::deployApp(
  appName = Sys.getenv("APP_NAME"),
  appTitle = Sys.getenv("APP_TITLE"),
  account = account_name,                    # your Connect username
  server = account_server                    # the Connect server, see rsconnect::accounts()
)
