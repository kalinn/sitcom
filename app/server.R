
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#
library(oro.nifti)
library(scales)
rootdir = './'
imgdir = './data/flairs'
mapdir = './data/oasisMaps'

shinyServer(function(input, output) {

  newSubj <- reactive({
    subject = input$subj
    flair = readNIfTI(file.path(imgdir, paste0("FLAIR_", subject, ".nii.gz")), reorient=FALSE)
    pMap = readNIfTI(file.path(mapdir, paste0("prob_map_", subject, ".nii.gz")), reorient=FALSE)
    imgData = list()
    imgData[[1]] = flair
    imgData[[2]] = pMap
    return(imgData)
  })
  
  output$ui <- renderUI({
    subject = input$subj
    flair = readNIfTI(file.path(imgdir, paste0("FLAIR_", subject, ".nii.gz")), reorient=FALSE)
    fDim = dim(flair)
    list(
      'ui1'=sliderInput("sagittal", "Sagittal slice:", min = 1, max = fDim[1], value = 80, step = 1),
      'ui2'=sliderInput("axial", "Axial slice:", min = 1, max = fDim[3], value = 80, step = 1), 
      'ui3'=sliderInput("coronal", "Coronal slice:", min = 1, max = fDim[2], value = 80, step = 1))
  })
  
  output$displayPlot <- renderPlot({
    ns = newSubj()
    fl = ns[[1]]
    mp = ns[[2]]
    thresh = input$thresh
    tMap = mp
    tMap[tMap < thresh] = NA
    if(input$overlayOnOff){
      orthographic(fl, tMap, xyz=c(input$sagittal, input$coronal, input$axial), col.y=alpha("red", input$overlay))
    } else{
      orthographic(fl, xyz=c(input$sagittal, input$coronal, input$axial))
    }
  })

})
