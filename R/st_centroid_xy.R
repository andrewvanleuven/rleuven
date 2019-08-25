st_centroid_xy <- function(df) {
  df %>%
    mutate(centroid = st_centroid(geometry),
           x = sapply(centroid, "[[", 1),
           y = sapply(centroid, "[[", 2)) %>%
    select(everything(),x,y,geometry,-centroid)
}
