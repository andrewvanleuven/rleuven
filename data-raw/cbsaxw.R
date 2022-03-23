## code to prepare `cbsaxw` dataset goes here
library(tidyverse)
library(tidycensus)
library(rleuven)
library(tigris)
library(sf)

xw <- read_csv("data-raw/xw.csv") |>
  select(-ssacounty,-ssast) |> distinct() |>
  mutate(countyname = str_to_title(countyname, locale = "en")) |>
  rename(county = countyname,
         cty_fips = fipscounty,
         cbsa_name = cbsaname) |>
  select(cty_fips,county,state) |>
  filter(!state %in% c("PR","AK","HI"),
         county != "Statewide")
cityxw <- read_csv("data-raw/cbsa_cities.csv") |>
  select(`CBSA Code`,`Principal City Name`,`FIPS State Code`,`FIPS Place Code`,If) |>
  mutate(city_fips = paste0(`FIPS State Code`,`FIPS Place Code`)) |>
  filter(If == 1) |>
  rename(cbsa_fips = `CBSA Code`,
         cbsa_main_city = `Principal City Name`) |>
  select(cbsa_fips,cbsa_main_city,city_fips)
city_pop <- read_csv("data-raw/city_pop.csv") |>
  select(SUMLEV:CENSUS2010POP,POPESTIMATE2015,POPESTIMATE2018) |>
  mutate(STATE = as.character(str_pad(STATE, 2, pad = "0")),
         PLACE = as.character(str_pad(PLACE, 5, pad = "0")),
         city_fips = paste0(STATE,PLACE),
         city_pop_10 = as.numeric(CENSUS2010POP),
         city_pop_15 = as.numeric(POPESTIMATE2015),
         city_pop_18 = as.numeric(POPESTIMATE2018)) |>
  filter(PLACE != "00000",
         PLACE != "99990",
         SUMLEV == 162,
         !is.na(city_pop_10)) |>
  select(city_fips, NAME, STNAME, city_pop_10, city_pop_15, city_pop_18) |>
  rename_all(tolower)
cities <- left_join(cityxw,city_pop) |>
  filter(city_pop_10 > 0)
ctyxw <- read_csv("data-raw/cbsa.csv") |>
  select(-st_fips,-cty_type) |>
  left_join(.,cities)
rucc <- read_csv("data-raw/rucc.csv") |>
  mutate(FIPS = as.character(str_pad(FIPS, 5, pad = "0"))) |>
  rename(cty_fips = FIPS,
         rucc = RUCC_2013) |>
  select(cty_fips,rucc)
cz <- read_csv("data-raw/cz.csv") |>
  mutate(cty_fips = as.character(str_pad(cty_fips, 5, pad = "0"))) |>
  rename(cty_fips = cty_fips,
         cz = cz2000) |>
  select(cty_fips,cz)
cty_pop <- get_decennial(geography = "county", variables = "P001001", year = 2010) |>
  select(GEOID,value) |>
  rename(cty_fips = GEOID,
         cty_pop_10 = value)
cty_seats <- read_csv("data-raw/county_seats.csv") |>
  mutate(cty_seat = ifelse(grepl("County Seat", feature), 1,0),
         st_captl = ifelse(grepl("State Capital", feature), 1,0),
         #second_cty_seat = ifelse(grepl("2", feature), 1,0),
         city_fips = as.character(str_pad(city_fips, 7, pad = "0")),
         city_fips2 = as.character(str_pad(city_fips2, 7, pad = "0")),
         cty_fips = as.character(str_pad(cty_fips, 5, pad = "0"))) |>
  select(-feature,-city_fips2,-city2) |> arrange(cty_fips)

seats <- cty_seats |> filter(cty_seat == 1) |>
  select(-county,-state,-cty_seat) |>
  rename(seat_fips = city_fips,
         seat = city, seat_st_cap = st_captl)
city_xw <- read_csv("data-raw/city_xw.csv") |>
  mutate(cty_fips = as.character(str_pad(county_fips, 5, pad = "0")),
         city_fips = as.character(str_pad(city_fips, 7, pad = "0")),
         city = placenm) |>
  #filter(afact > 0.5) |>
  select(city_fips,city,cty_fips,county,city_pop_00)

st_list <- xw |> select(state) |> distinct() |> pull()
cities_xy <- places(state = st_list, cb = T)
xy_coords <- cities_xy |> st_as_sf() |>
  rename(city_fips = GEOID) |>
  select(city_fips,geometry) |>
  st_centroid_xy() |> st_drop_geometry()

cities_inc <- city_pop |> left_join(.,city_xw, by = "city_fips") |> select(-city) |>
  left_join(.,(cty_seats |> select(city_fips,cty_seat,st_captl)), by = "city_fips") |>
  filter(city_pop_10 > 99) |> arrange(city_fips) |>
  mutate(cty_seat = replace_na(cty_seat, 0),
         st_captl = replace_na(st_captl, 0)) |>
  left_join(.,xy_coords) |> filter(!is.na(x))

cbsaxw <- left_join(xw,ctyxw) |>
  left_join(.,rucc) |>
  left_join(.,cz) |>
  left_join(.,cty_pop) |>
  left_join(.,seats) |>
  rename_all(tolower) |>
  select(cty_fips,county,cbsa_main_city,state,city_fips,
         rucc:cty_pop_10,seat,seat_fips,cbsa_fips:csa) |>
  filter(!state %in% c("AK","HI")) |>
  arrange(cty_fips)

usethis::use_data(cbsaxw, overwrite = TRUE)
usethis::use_data(cities_inc, overwrite = TRUE)

