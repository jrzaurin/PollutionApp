library(shiny)

source("AirPollution.R")
#below simply calling the functions within AirPollution.R

shinyServer(
  function(input, output) {

      output$prediction <- renderPrint({
      df <- data.frame(lon = input$lon, lat = input$lat, radius = input$r)
      pollutant(df)})

      output$levelPlot <- renderPlot({
      df <- data.frame(lon = input$lon, lat = input$lat, radius = input$r)    
      pm2.5plot(df)})

  }
)
