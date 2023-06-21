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
rsconnect::addServer(
  httr::modify_url(Sys.getenv("CONNECT_URL"), path = "__api__"),
  name = Sys.getenv("CONNECT_NAME")
)

rsconnect::connectApiUser(
  account = Sys.getenv("CONNECT_USER"),
  server = Sys.getenv("CONNECT_NAME"),
  apiKey = Sys.getenv("CONNECT_TOKEN")
)

appFiles <- list.files(getwd(), recursive = TRUE)
appFiles <- appFiles[!grepl(".Renviron|.Rprofile|renv|rstudio_|deliverables|dev|data-raw|docker", appFiles)]

rsconnect::deployApp(
  appDir = getwd(),
  appName = Sys.getenv("APP_NAME"),
  appFiles = appFiles,
  appPrimaryDoc = "app.R",
  account = Sys.getenv("CONNECT_USER"),
  server = Sys.getenv("CONNECT_NAME"),
  forceUpdate = TRUE,
  lint = FALSE
)
