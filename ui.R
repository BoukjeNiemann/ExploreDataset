#
# This defines an app with tabs, showing mtcars in different ways
#

library(shiny)

# Define UI for application that draws a plot
shinyUI(
  
  # Application title
  navbarPage("Explore Mtcars Dataset",
    # first tab
    tabPanel("Documentation", 
             h3("Explore the Mtcars Dataset"),
             br(),
             p("This app gives a few possibilities to explore a dataset, using the r-dataset ",
                strong(em("mtcars")), " as an example."),
             br(),
             p("On the ", strong("Table"), " tab you can walk through the data, sort it by column, 
                and even search for data."),
             p("On the ", strong("Summary"), " tab, you can see the output of the ", em("summary"),
             " function on it."),
             p("On the ", strong("Plot"), " tab you can do some exploring by plotting 
                a variable you chose against the ", em("mpg"), " variable and calculate the correlation."),
             br(),
             p("Have fun!")
             ),
             
    #second tab
    tabPanel("Table", DT::dataTableOutput("table")),

    #third tab
    tabPanel("Summary", verbatimTextOutput("summary")
             ),
    
    #fourth tab
    tabPanel("Plot",
        # Sidebar with a selection box and checkbox 
        sidebarLayout(
            sidebarPanel(
                selectInput("variable",
                            "Plot mpg versus:",
                            choices = colnames(mtcars)[2:length(mtcars)]),
                checkboxInput("showModel", "Show linear model")
            ),
        
        # Show a plot of the generated variables
            mainPanel(
                h3(textOutput("caption")),
                plotOutput("carPlot"),
                width = 4
            ),
            position = "right"
        )
    )    
  )
)
