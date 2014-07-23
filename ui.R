library(shiny)

# Define UI for dataset viewer application
shinyUI(
    pageWithSidebar(
    # Application title
    headerPanel("Air Pollution across the US"),

    sidebarPanel(
       numericInput("lat","latitude", 39.28),
       numericInput("lon","longitude", -76.61),       
       numericInput("r","radius in miles", 10),     		
       submitButton("Submit")
       ),
    mainPanel(
    helpText("This App will use the datasets at the United States Environment Protection Agency to give you an idea of the air pollution at a given location. To that aim, simply introduce the latitude and longitude of a certain location you would like to explore (in the US, latitude is positive and longitude is negative) and a radius in miles. Once these parameters are introduced the App will return the annual levels of Ozone (ppm) and PM2.5 (Micrograms per cubic meter) based on the 2013 measurements, averaging all monitors within the specified radius. Note that depending on the coordinates introduced, the radius parameter should have a large value to include a monitor. In addition, the App will also plot the evolution of PM2.5 for the availbale measurements in 2014, measured by the closest monitor to the introduced location."),
	h4('Levels of Ozone and PM2.5'),
    verbatimTextOutput("prediction"),
    plotOutput("levelPlot")    
     )
  )
)
