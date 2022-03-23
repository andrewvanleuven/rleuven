tab <- function(df,x){
  require(janitor)
  df |>
    tabyl(x) |>
    adorn_totals("row") |>
    adorn_pct_formatting()}


