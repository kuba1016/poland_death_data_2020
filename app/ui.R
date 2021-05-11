library(shiny)

ui <- dashboardPage(
  dashboardHeader(title = "Deaths in Poland 2020."),
  dashboardSidebar(),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(plotOutput("plot1", height = 600),
        width = 10,
        title = "Week by week % change in deaths registered 2019/2020",
        solidHeader = TRUE
      ),
      box(selectInput("voiv", "voivodeship", choices = unique(diff_df$name)), width = 2)
    )
  )
)
