wiki_pop_plot <- function(city,state){
  require(rvest); require(gt); require(tidyverse)
  name_id = paste0(gsub(" ", "_", city),',_',state)
  page <- read_html(sprintf('https://en.wikipedia.org/wiki/%s',name_id))
  wiki_scrape <- page |>
    html_element(".toccolours") |>
    html_table(header = F) |>
    select(census_year = 1, population = 2) |>
    filter(census_year %in% seq(1780, 2020, by=10)) |>
    mutate(population = as.numeric(gsub(",", "", population)),
           census_year = lubridate::ymd(sprintf("%s-01-01",census_year)))
  scrape_name <- page |>
    html_element('#firstHeading') |>
    html_text2()
  wiki_scrape |>
    ggplot() +
    aes(x = census_year, y = population) +
    geom_line(color = 'cornflowerblue') +
    geom_point(size = 1, shape = 21, fill = 'white') +
    theme_minimal(base_family = 'IBM Plex Mono') +
    scale_y_continuous(labels = scales::comma) +
    theme(axis.title = element_text(face = 'bold'),
          plot.title = element_text(face = 'bold')) +
    labs(x = 'Census Year', y = 'Decennial Population',
         caption = 'Source: Wikipedia & U.S. Census',
         title = glue::glue('Historical Populations of {scrape_name}'))
}
