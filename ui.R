library(shiny)
library(ggplot2)

precio <- read.csv("Precio.csv", header = T)
precio$Fecha <- as.Date(precio$Fecha, "%d/%m/%Y")
attach(precio)

shinyUI(fluidPage(
  

  titlePanel("Precio Semanal del Cerdo en Pie"),
  

  sidebarLayout(
    sidebarPanel(
      dateRangeInput("FFecha", "Rango de Fechas", start = (max(precio$Fecha)-63), 
                     end = max(precio$Fecha), format = "dd-mm-yyyy", 
                     language = "es", min = min(precio$Fecha), 
                     max = max(precio$Fecha)),
      
      selectInput("Region", "Región", choices = levels(Region)),
      hr(),
      br(),
      h5("Desarrollado por:"),
      tags$img(src = "ControlG.png", height = 100, width = 100),
      h5("Info:"),
      h6("jclopez59@gmail.com"),
      h6("dagc32@gmail.com"),
      br(),
      h6("Fuente: Porkcolombia, Ronda de Precios.")
      ),
    

    mainPanel(
      tabsetPanel(
        tabPanel("Región", 
                 plotOutput("GrafxReg"),
                 plotOutput("Var"),
                 tableOutput("General"),
                 h4("Fuente: Porkcolombia, Ronda de Precios."),
                 h6("https://asociados.porkcolombia.co/porcicultores/index.php?option=com_porcicultores&view=cifras&Itemid=104&ronda=2017")
        ),
        
        #tabPanel("Variación Precio",
        #         #plotOutput("Var"),
        #         tableOutput("Variacion"),
        #         h4("Fuente: Porkcolombia, Ronda de Precios."),
        #         h6("https://asociados.porkcolombia.co/porcicultores/index.php?option=com_porcicultores&view=cifras&Itemid=104&ronda=2017")
        #),
        
        tabPanel("General",
                 plotOutput("GrafREs"),
                 tableOutput("Resumen"),
                 h4("Fuente: Porkcolombia, Ronda de Precios."),
                 h6("https://asociados.porkcolombia.co/porcicultores/index.php?option=com_porcicultores&view=cifras&Itemid=104&ronda=2017")
        ),
        
       tabPanel("A Cerca de",
                h3("Desarrollado por:"),
                tags$img(src = "ControlG.png", height = 200, width = 200,
                                 align = "center"),
                h3("Soluciones Estadísticas y Tecnológicas"),
                hr(),
                h4("Juan Carlos López M."),
                h6("Zootecnista - Especialista en Estadística"),
                h6("jclopez5@unal.edu.co - 300 322 3901"),
                br(),
                h4("Diego A. Giraldo C."),
                h6("Administrador Agropecuario"),
                h6("dagc32@gmail.com - 321 817 7447"),
                br(),
                h5("Este aplicativo sirve como fuente de consulta de los 
                   precios del cerdo en pie publicados por Porkcolombia semanalmente.
                   La información mostrada corresponde a datos disponibles en la 
                   pagina web https://asociados.porkcolombia.co/porcicultores/
                   index.php?option=com_porcicultores&view=cifras&Itemid=104&ronda=2017"))
        )
    )
  )
))
