ncaa_hex <- function(university,secondary=c('TRUE','FALSE')){
  df <- college_hex
  require("tidyverse")
  if(missing(secondary)) {
    secondary=F
  }
  search_key <- str_to_lower(university)
  first_run <- df %>%
    filter(str_detect(hex_color,search_key))
  if (secondary==FALSE) return({first_run %>%
      filter(str_detect(hex_color,"_1"))})
  if (secondary==TRUE) return({first_run %>%
      filter(str_detect(hex_color,"_2"))})
}
