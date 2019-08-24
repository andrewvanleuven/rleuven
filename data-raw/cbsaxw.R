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
ctyxw <- read_csv("data-raw/cbsa.csv") %>%
  select(-st_fips,-cty_type)
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
         cty_pop = value)

cbsaxw <- left_join(xw,ctyxw) %>%
  left_join(.,rucc) %>%
  left_join(.,cz) %>%
  left_join(.,cty_pop) %>%
  rename_all(tolower) %>%
  select(cty_fips,county,state,rucc:cty_pop,cbsa_fips:csa) %>%
  arrange(cty_fips)

usethis::use_data(cbsaxw, overwrite = TRUE)