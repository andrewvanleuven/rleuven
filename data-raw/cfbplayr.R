## code to prepare `cfbplayr` dataset goes here
library(tidyverse)
library(rvest)

cfbplayr_scrape <- function(year,type){
  url <- sprintf("https://www.sports-reference.com/cfb/years/%s-%s.html",year,type)
  read_html(url) %>%
    html_table(fill = T) %>%
    as.data.frame() %>%
    janitor::row_to_names(1) %>%
    janitor::clean_names() %>%
    mutate(player = str_replace_all(player,'\\*', '')) %>%
    filter(rk != "Rk") %>% select(-rk) %>% arrange(player) %>%
    mutate(yr = year) %>% select(player,yr,everything())
}

stats <- c("passing","rushing","receiving")

for (i in 2001:2015) {
  for (j in stats) {
    nam <- paste0(j,i)
    assign(nam, cfbplayr_scrape(i,j))}}
beepr::beep()

cfbplayr_pass    <- bind_rows(lapply((ls(pattern='pas*')), get))
cfbplayr_rush    <- bind_rows(lapply((ls(pattern='rus*')), get))
cfbplayr_receive <- bind_rows(lapply((ls(pattern='rec*')), get))

for (i in 2001:2015) {for (j in stats) {rm(list=paste0(j,i))}}
rm(i,j,nam,stats)

usethis::use_data(cfbplayr_pass)
usethis::use_data(cfbplayr_rush)
usethis::use_data(cfbplayr_receive)
