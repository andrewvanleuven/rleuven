freqTab <- function(df,var,maxvals) {
  require("dplyr")
  if(missing(maxvals)) {
    maxvals=10
  }
  maxv <- (maxvals + 1)
  dfs <- as_tibble(df) %>% select(var)
  dft <- table(dfs)
  varname <- str_to_upper(var,locale = "en")
  as.data.frame(dft) %>%
    mutate(p = round((Freq/(sum(Freq)/100)), digits=1))%>%
    mutate(rank = rank(desc(p))) %>%
    filter(rank < maxv) %>%
    arrange(desc(Freq)) %>%
    select(-rank) %>%
    `colnames<-`(c(varname,"N","Percent"))
}
