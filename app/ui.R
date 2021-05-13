library(shiny)

##### header#######

header <- dashboardHeader(title = "Deaths in Poland 2020.")

###### header end#####

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Deaths by age group", tabName = "age_group"),
    menuItem("2019 ~ 2020 deaths", tabName = "diff_tab"),
    menuItem("Map", tabName = "map"),
    menuItem("About", tabName = "about")
  )
)
###### body #######

body <- dashboardBody(
  ## tab Items##
  tabItems(
    ### tab age_group
    tabItem(
      tabName = "age_group",
      fluidRow(
        box(plotOutput("plot_age", height = 600),
          width = 10,
          title = "age_group"
        ),
        box(checkboxGroupInput("age",
          "age",
          choices = c("All", unique(base_df$age_group)),
          selected = "All"
        ), width = 2)
      )
    ),
    tabItem(
      tabName = "diff_tab",
      fluidRow(
        box(plotOutput("plot1", height = 600),
          width = 10,
          title = "Week by week % change in deaths registered 2019/2020",
          solidHeader = TRUE
        ),
        box(checkboxGroupInput("voiv", "voivodeship",
          choices = c("All", unique(diff_df$name)),
          selected = "All"
        ),
        width = 2
        )
      )
    ),
    tabItem(
      tabName = "map",
      h2("Dashboard map content")
    ),
    tabItem(
      tabName = "about",
      h2("Dashboard about content")
    )
  )
)

###### body end#####

dashboardPage(header, sidebar, body)
