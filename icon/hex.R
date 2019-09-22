library(tidyverse)
library(tidycensus)
library(rleuven)
library(tigris)
library(sf)
library(hexSticker)
options(tigris_use_cache = TRUE)
options(tigris_class = "sf")
#df <- data.frame(
#  lon=c(-85.512090, -77.857188, -77.857188, -85.512090, -85.512090),
#  lat=c(43.521076, 43.521076, 38.531213, 38.531213, 43.521076)
#  )
#poly <- st_sf(st_sfc(st_polygon(list(as.matrix(df)))), crs = 4326)
midwest <- counties(state = c("OH","IN","MI","IL","WI"), cb = T) %>%
  filter(NAME != "Keweenaw")
  #st_transform(crs = 4326) %>%
  #st_intersection(poly,.)
midw_st <- st_dissolve(midwest,STATEFP)

(p <- ggplot() +
  geom_sf(data = midwest, alpha = 0, size = .5) +
  geom_sf(data = midw_st, size = 1, alpha = 0) +
  theme_icon())




p.sticker <- sticker(
  p, package=" ",
  h_color = "#478bca", h_fill = "#478bca",
  filename="icon/boxplot-icon-sticker.png"
)





