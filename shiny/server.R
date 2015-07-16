library(shiny)

# init global variables
userDB <<- data.frame()
sexDB <<- c(male="Male", female = "Female")
professionDB <<- c(teacher = "Teacher", doctor = "Doctor", lawer = "Lawer", other = "Other")

# calculates the sex distribution
sexCount <- function(u) {
    t <- table(u$sex)
    r <- c()
    if(is.na(t["Male"]))
        r <- c(Male = 0, Female = as.vector(t["Female"]))
    else if(is.na(t["Female"]))
        r <- c(Male = as.vector(t["Male"]), Female = 0)
    else
        r <- t
    r
}

shinyServer(
    function(input, output) {
        
        # create a reactive variable to be resued by the following output variable.
        users <- reactive({ 
            
            # validate input
            validate(
                need(input$name!="", "Please set the user name")                
            )
            
            # read input
            user <- data.frame(name = input$name, 
                               sex = sexDB[input$sex], 
                               profession = professionDB[input$profession], 
                               birthday = as.character(input$birthday))
            
            # update the global variable with the double left arrow sign.
            userDB <<- rbind(user, userDB)
            userDB
        })
        
        # output a table, rownames are excluded
        output$userTable <- renderTable(users(), include.rownames = F)
        
        # ouput a text
        output$maleText <- renderText(sexCount(users())["Male"])
        
        output$femaleText <- renderText(sexCount(users())["Female"])
        
        # output a bar plot for different sexes.
        output$sexBar <- renderPlot({
            barplot(sexCount(users()), col = 'forestgreen', border = 'white')
        })
    }
)