#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
attach(iris)
library(shiny)
library(rpart)
fit = rpart(Species ~., iris)
# Define UI for application that draws a histogram
ui <- fluidPage(
   # Application title
   titlePanel("Predicting Flower Species: Iris Dataset"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         sliderInput("Sepal.Length",
                     "Sepal Length:",
                     min = 4,
                     max = 8,
                     value = .5),
         sliderInput("Sepal.Width",
                     "Sepal Width:",
                     min = 2,
                     max = 5,
                     value = .25),
         sliderInput("Petal.Length",
                     "Petal Length:",
                     min = 1,
                     max = 7,
                     value = .5),
         sliderInput("Petal.Width",
                     "Petal Width:",
                     min = 0.1,
                     max = 2.5,
                     value = .25)
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
         textOutput("prediction")
      )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$prediction <- renderText({
      new_data = data.frame(
        Sepal.Length = input$Sepal.Length,
        Sepal.Width = input$Sepal.Width,
        Petal.Length = input$Petal.Length,
        Petal.Width = input$Petal.Width)
        
        species = predict(fit, new_data, type="class")
        print(new_data)
        paste("This flower is:", species)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
