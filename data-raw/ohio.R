## code to prepare `ohio` dataset goes here

library(tidyverse)

ohio <- read_csv('data-raw/ohio.csv') |>
  filter(place != 99990 & place != 0 & place_pop_2010 != "A") |>
  mutate(place_name = str_replace_all(place_name, "\\(pt.\\)","")) |>
  group_by(place_name) |>
  top_n(1, place_pop_2010) |>
  mutate(place_pop_2010 = as.numeric(place_pop_2010)) |>
  filter(place_pop_2010 > 75 & !is.na(place_pop_2010)) |>
  distinct() |>
  arrange(county_name,place_name)

usethis::use_data(ohio,overwrite = T)
