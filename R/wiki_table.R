wiki_table <- function(place){
  map_df(.x = place,
         .f = function(x){
           require(rvest); require(gt); require(tidyverse)
           name_id = gsub(" ", "_", x)
           page <- read_html(sprintf('https://en.wikipedia.org/wiki/%s',name_id))
           scrape_name <- page |>
             html_element('#firstHeading') |>
             html_text2()
           wiki_scrape <- page |>
             html_element(".toccolours") |>
             html_table(header = F) |>
             select(census_year = 1, population = 2) |>
             filter(census_year %in% seq(1780, 2020, by=10)) |>
             mutate(population = as.numeric(gsub(",", "", population)),
                    census_year = lubridate::ymd(sprintf("%s-01-01",census_year)),
                    census_year = lubridate::year(census_year),
                    name = scrape_name) |>
             select(name, census_year, population)
         })
}
