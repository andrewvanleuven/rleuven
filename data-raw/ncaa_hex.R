library(tidyverse)
library(rvest)
library(purrr)

ncaa_list <- read_html("https://teamcolorcodes.com/ncaa-color-codes/") %>%
  html_nodes("h4~ h4+ p a") %>%
  xml_attrs() %>%
  map_df(~as.list(.)) %>%
  filter(str_detect(href,"santa-clara",negate = T)) %>%
  #slice(186:261) %>%
  #sample_n(4) %>%
  pull()

school_name <- function(w_pull) {
  w_pull %>%
    html_node(".entry-title") %>%
    html_text() %>%
    str_replace_all("’","") %>%
    str_replace_all("\\.","") %>%
    str_replace_all(" Team","") %>%
    str_replace_all(" Color ","") %>%
    str_replace_all(" Colors","") %>%
    str_replace_all("Codes","") %>%
    str_replace_all("codes","") %>%
    str_to_lower() %>%
    str_replace_all(" ","_")
}

get_hex <- function(school_url){
  web_pull <- read_html(school_url)
  school <- school_name(web_pull)
  univ <- web_pull %>%
    html_nodes(".colorblock")
  hex_value <- function(list_item) {
    text_mess <- as.character(list_item)
    text_mess %>%
      str_extract("[:xdigit:]{6}") %>%
      paste0("#",.) %>%
      str_to_upper()
  }
  hex_list <- c(hex_value(univ[1]),hex_value(univ[2]))
  enframe(hex_list) %>%
    mutate(hex_color = paste(school,row_number(), sep = "_")) %>%
    select(hex_color,value)
}
get_hex(ncaa_list[3])


for (i in ncaa_list) {
  web_pull <- read_html(i)
  school <- school_name(web_pull)
  nam <- paste("hex",i,sep = "_")
  assign(nam, get_hex(i))
}

dfs = sapply(.GlobalEnv, is.tibble)

ncaa_hex <- do.call(rbind, mget(names(dfs)[dfs]))

beepr::beep()

rm(list=paste0("hex_",ncaa_list))

college_hex <- ncaa_hex %>% remove_rownames() %>% arrange(hex_color)

# Use Data ----------------------------------------------------------------
usethis::use_data(college_hex, overwrite = TRUE)
