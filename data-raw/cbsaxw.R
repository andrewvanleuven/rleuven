## code to prepare `cbsaxw` dataset goes here
library(tidyverse)
library(tidycensus)

xw <- read_csv("data-raw/xw.csv") %>%
  select(-ssacounty,-ssast) %>% distinct() %>%
  mutate(countyname = str_to_title(countyname, locale = "en")) %>%
  rename(county = countyname,
         cty_fips = fipscounty,
         cbsa_name = cbsaname) %>%
  select(cty_fips,county,state) %>%
  filter(!state %in% c("PR","AK","HI"),
         county != "Statewide")
cityxw <- read_csv("data-raw/cbsa_cities.csv") %>%
  select(`CBSA Code`,`Principal City Name`,`FIPS State Code`,`FIPS Place Code`,If) %>%
  mutate(city_fips = paste0(`FIPS State Code`,`FIPS Place Code`)) %>%
  filter(If == 1) %>%
  rename(cbsa_fips = `CBSA Code`,
         cbsa_main_city = `Principal City Name`) %>%
  select(cbsa_fips,cbsa_main_city,city_fips)
city_pop <- read_csv("data-raw/city_pop.csv") %>%
  select(SUMLEV:CENSUS2010POP,POPESTIMATE2015,POPESTIMATE2018) %>%
  mutate(STATE = as.character(str_pad(STATE, 2, pad = "0")),
         PLACE = as.character(str_pad(PLACE, 2, pad = "0")),
         city_fips = paste0(STATE,PLACE),
         city_pop = as.numeric(CENSUS2010POP),
         city_pop_15 = POPESTIMATE2015,
         city_pop_18 = POPESTIMATE2018) %>%
  filter(PLACE != "00000",
         PLACE != "99990",
         SUMLEV == 162,
         !is.na(city_pop)) %>%
  select(city_fips, NAME, STNAME, city_pop_10, city_pop_15, city_pop_18) %>%
  rename_all(tolower)
cities <- left_join(cityxw,city_pop) %>%
  filter(city_pop > 0)
ctyxw <- read_csv("data-raw/cbsa.csv") %>%
  select(-st_fips,-cty_type) %>%
  left_join(.,cities)
rucc <- read_csv("data-raw/rucc.csv") %>%
  mutate(FIPS = as.character(str_pad(FIPS, 5, pad = "0"))) %>%
  rename(cty_fips = FIPS,
         rucc = RUCC_2013) %>%
  select(cty_fips,rucc)
cz <- read_csv("data-raw/cz.csv") %>%
  mutate(cty_fips = as.character(str_pad(cty_fips, 5, pad = "0"))) %>%
  rename(cty_fips = cty_fips,
         cz = cz2000) %>%
  select(cty_fips,cz)
cty_pop <- get_decennial(geography = "county", variables = "P001001", year = 2010) %>%
  select(GEOID,value) %>%
  rename(cty_fips = GEOID,
         cty_pop_10 = value)

cbsaxw <- left_join(xw,ctyxw) %>%
  left_join(.,rucc) %>%
  left_join(.,cz) %>%
  left_join(.,cty_pop) %>%
  rename_all(tolower) %>%
  select(cty_fips,county,cbsa_main_city,state,city_fips,rucc:cty_pop_10,cbsa_fips:csa) %>%
  arrange(cty_fips)

usethis::use_data(cbsaxw, overwrite = TRUE)
usethis::use_data(city_pop, overwrite = TRUE)
