library(shiny)
library(networkD3)
source('my_steemit_network_functions.R')
server <- function(input, output) {
 my_reactive_network <- eventReactive(input$goButton, {
   get_network(input$nev)
 })
 output$my_net <- networkD3::renderForceNetwork(my_reactive_network())
}


ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput('nev', "Név"),
      actionButton("goButton", "Get plot!")
    ),
    mainPanel(forceNetworkOutput("my_net"))
  )
)

shinyApp(ui = ui, server = server)

