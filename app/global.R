library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(vroom)
library(tidyverse)

# lodding data
base_df <- vroom("../app/data/general.csv")
# prepering data for first page plot.
diff_df <- base_df %>%
  group_by(name, week_no, year_date) %>%
  summarise(total_deaths = sum(num_deaths)) %>%
  unite(col = "week_year", c(week_no, year_date), sep = "_") %>%
  group_by(week_year, name) %>%
  summarise(weekly_total = sum(total_deaths)) %>%
  separate(week_year, into = c("week", "year"), remove = T) %>%
  # select(-week,-year) %>%
  pivot_wider(names_from = year, values_from = weekly_total) %>%
  mutate(diff2020_2019 = (`2020` - `2019`) / `2019`)