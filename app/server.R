server <- function(input, output) {

  # interactivity for the death number difrences

  plot_diff_df <- reactive({
    diff_df %>%
      filter(name == input$voiv)
  })

  output$plot1 <- renderPlot({
    plot_diff_df() %>%
      ggplot(aes(week, diff2020_2019, group = 1, fill = if_else(diff2020_2019 > 0, "green", "red"))) +
      geom_col(show.legend = F) +
      # geom_abline(intercept = 0, slope = 0, color = "red")+
      scale_y_continuous(labels = scales::label_percent()) +
      scale_x_discrete(guide = guide_axis(n.dodge = 2)) +
      coord_flip() +
      theme_minimal() +
      facet_wrap(~name, nrow = 4, scales = "fixed", shrink = F) +
      labs(
        x = "Week",
        y = "% change in deaths registered 2019/2020"
      )
  })
}