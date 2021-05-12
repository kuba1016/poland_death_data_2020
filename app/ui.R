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
    ###tab age_group
    tabItem(
      tabName = "age_group",
      fluidRow(
        box(plotOutput("age_group_plot", height = 600),
            width = 10,
            title = "age_group"),
        box(pickerInput("age","age",
                        choices = c("bla","nla"),
                        options = list(
                          `actions-box` = TRUE),
                        multiple = TRUE))
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
        box(selectInput("voiv", "voivodeship", 
                        choices = c("All",unique(diff_df$name)),
                        
                        
                        ),
            width = 2)
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
