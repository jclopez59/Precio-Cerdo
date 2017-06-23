library(shiny)
library(chron)
library(ggplot2)

precio <- read.csv("Precio.csv", header = T)
precio$Fecha <- as.Date(precio$Fecha, "%d/%m/%Y")
precio <- precio[order(precio[, 3], precio[, 2]), ]
precio$Varicion <- c(0,diff(precio$Precio))


attach(precio)


shinyServer(function(input, output) {
  
  PrecioF <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2] &
                              Region == input$Region, ])
  PrecioG <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2], ])
  Ant <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2] &
                            Region == levels(Region)[1], c(1,4)])
  Bog <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2] &
                            Region == levels(Region)[2], 4])
  Caribe <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2] &
                               Region == levels(Region)[3], 4])
  Eje <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2] &
                            Region == levels(Region)[4], 4])
  Valle <- reactive(precio [Fecha >= input$FFecha[1] & Fecha <= input$FFecha[2] &
                              Region == levels(Region)[5], 4])
  
  
  output$General <- renderTable(data.frame(PrecioF() [,c(1, 4, 5)]))
  
  output$GrafxReg <- renderPlot({plot(PrecioF()[,2], PrecioF()[,4], pch = 16,
                                      main = paste("Precio Semanal", input$Region),
                                      xlab = "Fecha", col = "darkblue",
                                      ylab = "Precio Kg en Pie ($)", lwd = 2,
                                      panel.first =  grid(), type = "b")})
  
  output$Var <- renderPlot({barplot(PrecioF()[,5],
                                    main = "Variación del Precio Respecto a la Semana Anterior",
                                    xlab = "Fecha", ylab = "Variación Precio ($)", 
                                    col = ifelse(PrecioF()[,5] < 0, 
                                                 "darkred", "darkgreen"))
    
    #output$Variacion <- renderTable({data.frame(Semana = PrecioF()[-1,1],
    #                                            Variación = diff(PrecioF()[,4]))})
    
    output$Resumen <- renderTable(data.frame(Ant(), Bog(), Caribe(), Eje(), Valle())
      
    )
   
    output$GrafREs <- renderPlot(qplot(Fecha, Precio, data=PrecioG(), shape = Region,
                                       color=Region, geom = c("point", "line"),
                                       main = "Precio Semanal", xlab = "Fecha",
                                       ylab = "Precio Kg en Pie") + 
                                   theme(legend.position="bottom"))
    
      })
})

