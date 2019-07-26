num_of_NAs <- function(x){
  df <- data.frame(sapply(x, function(y) sum(length(which(is.na(y))))))
  names(df) <- c("# of NAs")
  View(df)
}
