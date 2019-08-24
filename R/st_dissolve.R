st_dissolve <- function(df, group_var) {
  group_var <- enquo(group_var)
  df %>%
    group_by(!! group_var) %>%
    summarise(STATUS = 'dissolved')
}
