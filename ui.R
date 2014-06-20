library(shiny)


shinyUI(pageWithSidebar(
  headerPanel("MTCARS ANALYSIS!"),
  sidebarPanel(
    radioButtons( inputId= "predictor", label = "Nominal Predictor:", choices= c("V/S", "Transmission", "No. of forward gears", "No. of Carburetors", "No. of Cylinders"), selected="V/S", inline= FALSE ),
    radioButtons( inputId= "predictor2", label = "Numaric Predictor:", choices= c("Displacement", "Gross HP", "Rear axle ratio", "Weight", "1/4 mile time" ), selected="Displacement", inline= FALSE ),
    h1( "Get Started!" ),
    checkboxInput( inputId= "getStarted", label = "Display Instruction", value= FALSE ),
    verbatimTextOutput( "help" ),
    checkboxInput( inputId= "mtcars", label = "Display Mtcars Detail", value= FALSE ),
    verbatimTextOutput( "mtcars" )
  ),
  mainPanel(
    h3('Data Visuallization'),
    plotOutput( 'box' ),
    plotOutput( 'linearModel' )
  )
))
