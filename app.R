#App to test students on the concept of transcription and translation

#Load packages
library(BiocManager)
options(repos = BiocManager::repositories())
getOption("repos")

library(shiny)
library(Biostrings)

#load the ui object from github
#The purpose is to update the app w/o redeploying it

source(
  file = 
    "https://raw.githubusercontent.com/idohatam/Lost-in-expression/master/ui.R")

#load the server function from github

source(
  file = 
    "https://raw.githubusercontent.com/idohatam/Lost-in-expression/master/server.R")


# Run the application 
shinyApp(ui = ui, server = server)
