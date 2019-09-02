rand_ncolors <- function(df){
  n <- nrow(df)
  df <- inlmisc::GetColors(n)
  sample(df)
  print("Use `scale_fill_manual(values = n_colors)` for random palette.")
}
