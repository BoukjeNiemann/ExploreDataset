# This creates the output for the tabs defined in the ui.R
#

library(shiny)

# Define server logic required to draw a plot
shinyServer(function(input, output) {
    
    # create output table with 15 rows initially
    output$table <- DT::renderDataTable(
        DT::datatable(mtcars, options = list(pageLength = 15))
        )
    # create the summary
    output$summary <- renderPrint({summary(mtcars)})   

        # define the text for the formula of the plot
    formulaText <- reactive({
        paste("mpg ~", input$variable)
    }) 
    # calculation function of the correlation
    formulaCor <- reactive({
        cor(mtcars$mpg, mtcars[input$variable])
    })
    # create output text
    output$caption <- renderText({
        paste(formulaText(), ", correlation: ", round(formulaCor(),digits = 2))
        })
    # create output plot
    output$carPlot <- renderPlot({
        #create linear model
        model <- lm(as.formula(formulaText()), data = mtcars)
        with(mtcars, plot(as.formula(formulaText())))
        if(input$showModel){
            abline(model, col = "red", lwd = 2)}
        })
})
