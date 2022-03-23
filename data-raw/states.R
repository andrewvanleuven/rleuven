library(tigris)
library(tidyverse)
library(sf)

states_df <- states(T,'20m') |>
  st_drop_geometry() |>
  select(st_fips = 1,
         st_name = NAME,
         st_abbr = STUSPS)

counties_df <- counties(cb = T, resolution = '20m') |>
  st_drop_geometry() |>
  select(cty_fips = GEOID,
         cty_name = NAME,
         ct_fips = 2,
         st_fips = 1,
         st_abbr = STUSPS)



usethis::use_data(states_df, overwrite = TRUE)
usethis::use_data(counties_df, overwrite = TRUE)
