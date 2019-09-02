rand_ncolors <- function(df){
  n <- nrow(df)
  df <- inlmisc::GetColors(n)
  message("Use `scale_fill_manual(values = n_colors)` for random palette.")
  sample(df)
}
