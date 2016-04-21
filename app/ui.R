
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("OASIS Thresholded Probability Map"),
  
  # Sidebar with a slider input for number of samples
  sidebarPanel(
    selectInput("subj", "Choose a subject:", 
                choices = c(paste0('0', 1:9), paste0('1', 0:6), paste0('2', 0:7), '29', paste0('3', 0:3)),
                selected = '01'),
    sliderInput("thresh",
                "Threshold:",
                min = 0,
                max = 1,
                value = 0.5,
                step = .01),
    sliderInput("overlay",
                "Overlay transparency:",
                min = 0,
                max = 1,
                value = 0.5,
                step = .05),
    checkboxInput("overlayOnOff", "Overlay on/off:", value=TRUE),
    uiOutput("ui")
#    uiOutput("ui2"),
#    uiOutput("ui3")
  ),
  
  mainPanel(
    plotOutput("displayPlot", height="500px", width="500px")
  )
))

