library(tigris)
library(tidyverse)
library(sf)

ok_cty_pop <- read_csv('data-raw/nhgis_cty2020.csv') |>
  janitor::clean_names() |>
  filter(state == 'Oklahoma') |>
  select(cty_fips = geocode,cty_pop_2020 = 52)

ok_cty <- counties(40,T,'20m') |>
  st_drop_geometry() |>
  select(cty_fips = GEOID,
         cty_name = NAME) |>
  left_join(ok_cty_pop, by = "cty_fips") |>
  mutate(cty_fips = as.numeric(cty_fips))

# pops <- read_csv('data-raw/nhgis_place2020.csv') |>
#   filter(STATEA == 40) |>
#   mutate(city_fips = paste0(STATEA,PLACEA)) |>
#   select(city_fips,city_pop_2020 = U7B001)
write_csv(pops,'data-raw/nhgis_place2020a.csv')

city_xw <- read_csv('data-raw/ok_mable.csv') |>
  filter(afact > .5) |>
  mutate(city_fips = paste0(state,placefp)) |>
  select(city_fips,cty_fips = county)

cty_seats <- read_csv('data-raw/county_seats.csv') |>
  filter(state == 'OK') |>
  select(1,3,4)

ok_city <- places(40,T) |>
  st_drop_geometry() |>
  select(city_fips = GEOID,
         city_name = NAME) |>
  left_join(pops, by = 'city_fips') |>
  left_join(city_xw, by = 'city_fips') |>
  filter(not_na(cty_fips)) |>
  mutate(city_fips = as.numeric(city_fips),
         cty_fips = as.numeric(cty_fips)) |>
  left_join(cty_seats, by = c("city_fips", "cty_fips")) |>
  left_join(ok_cty, by = 'cty_fips') |>
  mutate(cty_seat = ifelse(is.na(feature),0,1),
         cty_name = paste0(cty_name,' County, Oklahoma')) |>
  select(-feature)

usethis::use_data(ok_city, overwrite = TRUE)

