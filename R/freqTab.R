freqTab <- function(df,var,maxvals,ties=c('TRUE','FALSE')) {
  require("dplyr")
  if(missing(maxvals)) {
    maxvals=10
  }
  if(missing(ties)) {
    ties=F
  }
  varname <- str_to_upper(var,locale = "en")
  g <- table(as_tibble(df) %>% select(var)) %>%
    as.data.frame() %>%
    mutate(p = round((Freq/(sum(Freq)/100)), digits=1)) %>%
    arrange(desc(Freq))
  if (ties==TRUE) return({g %>% top_n(maxvals) %>%
      `colnames<-`(c(varname,"N","Percent"))})
  if (ties==FALSE) return({g %>% filter(row_number(desc(p))<=maxvals) %>%
      `colnames<-`(c(varname,"N","Percent"))})
}
