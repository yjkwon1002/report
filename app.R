#library
library(readxl)

#save data and arrange
sales<-read_xlsx("price_shiny.xlsx")
sales<-as.data.frame(sales)
row.names(sales)<-c(sales[,1])
sales[,1]<-NULL
sales

#shiny
library(shiny)

#define ui
ui <- fluidPage(
  titlePanel("Housing Sales in Seoul"),
  sidebarLayout(
    sidebarPanel(
      h4("Choose Year to compare the Housing Sales of Seoul."),
      selectInput("year", 
                  label = "Year:",
                  choices = c(2018,2019,2020,2021,2022),
                  selected = 2018)
    ),
    mainPanel(
      plotOutput(outputId = "price")
    )
  )
)

#define server
server <- function(input, output){
  output$price <- renderPlot({
    barplot(sales[,input$year],
            main=input$year,
            ylim=c(0,2500),
            ylab="Price")
  })
}

#run the app
shinyApp(ui=ui,server=server)
