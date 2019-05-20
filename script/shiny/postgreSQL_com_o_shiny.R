##-----------------------------------------------------------------------------------------------------------------------##
##                                                                                                                       ##
##    Nome: Alimentando o postgreSQL com o SHINY                                                                         ##
##                                                                                                                       ##
##                                                                                                                       ##
##    Fonte:#https://stackoverflow.com/questions/48254958/writing-information-into-postgresql-database-through-shiny-app  ##
##    Obs: Tem que criar o banco de dados, a tabela e as colunas no pgadmin                                          ##
##    Olhar o arquivo 'colocando colunas na criando tabela para shinyapp.SQL'                                                          ##
##                                                                                                                       ##
##    Steven Dutt-Ross e  Rafael Stavale                                                                                            ##
##    UNIRIO                                                                                                             ##
##-----------------------------------------------------------------------------------------------------------------------##

# Set libraries
library(RPostgreSQL)
library(shiny)

# Define the fields we want to save from the form
fields <- c("id", "message")

# Shiny app with two fields that the user can submit data for
shinyApp(
  ui = fluidPage(
    DT::dataTableOutput("responses", width = 300), tags$hr(),
    textInput("id", "ID", ""),
    textInput("message", "MESSAGE", ""),
    actionButton("submit", "Submit")
  ),
  server = function(input, output, session) {
    
    
    psql <- dbDriver("PostgreSQL")
    
    saveData <- function(data) {
      # Connect to the database
      pcon <- dbConnect(psql, dbname = "Appshiny", 
                        host = 'localhost',
                        port = 5432,
                        user = 'postgres',
                        password = 'SENHA')

      # Construct the update query by looping over the data fields
      query <- paste0("INSERT INTO meushiny (message) VALUES ( $1 
      )") 
  # Submit the update query and disconnect
      dbSendQuery(pcon, query, params=data[["message"]]) 
      dbDisconnect(pcon)
    }
    
    loadData <- function() {
      # Connect to the database
      pcon <- dbConnect(psql, dbname = "Appshiny", 
                        host = 'localhost',
                        port = 5432,
                        user = 'postgres',
                        password = 'SENHA')
      # Construct the fetching query
      query <- sprintf("SELECT * FROM meushiny") 
      # Submit the fetch query and disconnect
      data <- dbGetQuery(pcon, query)
      dbDisconnect(pcon)
      data
    }
    
    # Whenever a field is filled, aggregate all form data
    formData <- reactive({
      data <- sapply(fields, function(x) input[[x]])
      data
    })
    
    # When the Submit button is clicked, save the form data
    observeEvent(input$submit, {
      saveData(formData())
    })
    
    # Show the previous responses
    # (update with current response when Submit is clicked)
    output$responses <- DT::renderDataTable({
      input$submit
      loadData()
    })     
  }
)