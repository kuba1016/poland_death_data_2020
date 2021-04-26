# Loading lib 
library(tidyverse)
library(readxl)


## function to load and transform data
get_data <- function(path) {
  # get dates from xls
  dates <- read_excel(path = path, sheet = "TYGODNIE ISO8601") %>%
    mutate(TYDZIEŃ = str_extract(TYDZIEŃ, "T[0-9]{2}")) %>%
    rename(week = TYDZIEŃ) %>%
    mutate(DATA = lubridate::floor_date(DATA, "weeks", week_start = 1)) %>%
    distinct()
  # load and transform data
  df <-
    read_excel(path = path, sheet = 1, skip = 6) %>%
    rename(
      "age_group" = "...1",
      "code" = "...2",
      "name" = "...3"
    ) %>%
    slice(-(1:3)) %>%
    filter(
      age_group != "Ogółem",
      str_length(code) == 4
    ) %>%
    select(-code) %>%
    pivot_longer(cols = contains("T"), names_to = "week_no", values_to = "num_deaths") %>%
    left_join(dates, by = c("week_no" = "week")) %>%
    mutate(year_date = str_extract(path, "[0-9]{4}"))
}


# loading data 

df_full <-
  map(list.files("Downloads/zgony_wedlug_tygodni 2/", full.names = T), get_data)
