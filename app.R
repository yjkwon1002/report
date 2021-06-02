#library
library(readxl)

#save data and arrange
sales<-read_xlsx("price_shiny.xlsx")
sales<-as.data.frame(sales)
row.names(sales)<-c(sales[,1])
col.names(sales)<-c(2018,2019,2020,2021,2022)
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
              xlab="District",
              ylab="Price",
              names.arg=c("강남구", "강동구", "강북구", "강서구",
                          "관악구", "광진구", "구로구", "금천구",
                          "노원구", "도봉구", "동대문구",
                          "동작구", "마포구", "서대문구",
                          "서초구", "성동구", "성북구",
                          "송파구", "양천구", "영등포구",
                          "용산구", "은평구", "종로구",
                          "중구","중랑구"))
  })
}

#run the app
shinyApp(ui=ui,server=server)
