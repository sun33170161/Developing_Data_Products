library(shiny)

shinyUI(pageWithSidebar(
    headerPanel("User Management", windowTitle = T),
    
    sidebarPanel(
        textInput("name", "Name"),
        radioButtons("sex", "Sex", list(
            Male = "male", Female = "female"), inline = T),
        selectInput("profession", "Profession", list(
            Teacher = "teacher", 
            Doctor = "doctor", 
            Lawer = "lawer", 
            Other = "other"
        )),
        dateInput("birthday", "Birthday"),
        
        # submit button to post all the inputs
        submitButton("Add User")
    ),
    
    mainPanel(
        withTags({
            div(
                HTML("<strong>Hint: </strong>"),
                p("This is a simple user management application. It has the following functions"),
                ol(
                    li("add user"),
                    li("show users in a table"),
                    li("make statistics on user sex and show the result"),
                    li("displays the sex bar plot")
                ),
                p("Fill the left-side form and add some users to validate that please! Have fun!")
            )
        }),
        
        hr(),
        
        # outupt a table
        tableOutput("userTable"),
        
        # seperator
        hr(),
        
        # output sex summary
        h3("Sex Number: male ",
          textOutput("maleText", inline = T),
          ", female ",
          textOutput("femaleText", inline = T)  
        ),

        # output a bar plot
        plotOutput("sexBar")
    )
))