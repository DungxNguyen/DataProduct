library(shiny)
data( mtcars )


getPredictorSymbol <- function( predictor ){
  # Factors
  if( predictor == "V/S" ) return( "vs" )
  if( predictor == "Transmission") return( "am" )
  if( predictor == "No. of forward gears" ) return( "gear" )
  if( predictor == "No. of Carburetors" ) return( "carb" )
  if( predictor == "No. of Cylinders" ) return ( "cyl" )
  
  # Numeric
  if( predictor == "Displacement" ) return( "disp" )
  if( predictor == "Gross HP" ) return ( "hp" )
  if( predictor == "Rear axle ratio") return ( "drat" )
  if( predictor == "Weight") return ( "wt" )
  if( predictor == "1/4 mile time") return ( "qsec" )
}

helpParagraph <- function( getStarted ){
  if( getStarted ){
    return ( "This is mtcars analysis program. The program displays the relationships between Mile Per Gallon measurement of each car with its other features. The sidebar panel will read the input and produce the analysis diagrams in the main panel. There are 2 types of input: Selecting nominal features or numeric features. With nominal features, the progam will produce a box plot of Mile Per Gallon distribution with each value of selected feature. With numeric features, the program will create a linear model of estimation of Mile Per Gallon by the selected feature. The box plot diagram will be displayed in the top of the main panel, while the linear model diagram will be placed in the bottom of the main panel. The diagrams will be re-rendered each time a new feature is selected." )
  }
  return ( "Check above box to display documentation" )
}

mtcarsInfo <- function( displayed ){
  if( displayed ){
    return ( str( mtcars ) )
  }
  return ( "Check above box to display mtcars info" )
}

shinyServer(
  function(input, output) {
    output$box <- renderPlot({
      boxplot( mpg ~ mtcars[, getPredictorSymbol( input$predictor ) ], 
               data = mtcars, main = paste( "Summary of Miles Per Gallon to ", input$predictor, sep = " "),
               xlab = input$predictor, ylab = "Miles Per Gallon")
    })
    output$linearModel <- renderPlot({
      plot( mpg ~ mtcars[, getPredictorSymbol( input$predictor2 ) ], data = mtcars,
            main = paste( "Linear Model of Miles Per Gallon to ", input$predictor2, sep = " "),
            xlab = input$predictor2, ylab = "Miles Per Gallon" )
      abline( lm( mpg ~ mtcars[, getPredictorSymbol( input$predictor2 ) ], data = mtcars ), col = "red", lwd = 2 )
    })
    output$help <- renderPrint({ helpParagraph( input$getStarted ) })
    output$mtcars <- renderPrint({ mtcarsInfo( input$mtcars ) })
  }
)