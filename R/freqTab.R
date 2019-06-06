freqTab <- function(df,var) {
  dfs <- df %>% select(var)
  dft <- table(dfs)
  as.data.frame(dft) %>%
    mutate(p = round((Freq/(sum(Freq)/100)), digits=1))%>%
    mutate(rank = rank(desc(p))) %>%
    filter(rank < 16) %>%
    arrange(desc(Freq)) %>%
    select(-rank) %>%
    `colnames<-`(c(var,"N","Percent"))
}
