library(shiny)
source("")

shinyServer(function(input, output) {
  date_range <- reactive({
    levels(most_popular$DateRange)[input$dates]
  })

  output$date_display <- reactive({
    d <- unlist(strsplit(date_range(), "-"))
    paste("July", d, collapse = " - ")
  })

  output$map <- renderPlot({
    plot_map(date_range(), cols)
  })
})
