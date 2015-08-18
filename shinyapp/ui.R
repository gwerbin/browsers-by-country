library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Most popular browser by country"),
  sidebarPanel(
    sliderInput("dates", "Date range",
                min = 1, max = 7, step = 1, value = 1,
                ticks = FALSE, animate = TRUE),
    textOutput("date_display")
  ),
  mainPanel(
    plotOutput("map", height = '550px')
  )
))
