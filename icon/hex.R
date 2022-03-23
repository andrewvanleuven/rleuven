library(tidyverse)
library(tidycensus)
library(rleuven)
library(tigris)
library(sf)
library(magick)
library(hexSticker)
library(showtext)

options(tigris_use_cache = TRUE)
options(tigris_class = "sf")
theme_icon <- function () {
  theme_void() +
    theme(
      panel.background = element_rect(fill = "transparent", colour = NA),
      plot.background = element_rect(fill = "transparent", colour = NA),
      legend.background = element_rect(fill = "transparent", colour = NA),
      legend.box.background = element_rect(fill = "transparent", colour = NA)
    )
}
#df <- data.frame(
#  lon=c(-85.512090, -77.857188, -77.857188, -85.512090, -85.512090),
#  lat=c(43.521076, 43.521076, 38.531213, 38.531213, 43.521076)
#  )
#poly <- st_sf(st_sfc(st_polygon(list(as.matrix(df)))), crs = 4326)
midwest <- counties(state = c("OH","IN","MI","IL","WI"), cb = T) |>
  filter(NAME != "Keweenaw")
  #st_transform(crs = 4326) |>
  #st_intersection(poly,.)
midw_st <- st_dissolve(midwest,STATEFP)

font_add_google("Anonymous Pro", "google")
showtext_auto()

(p <- ggplot() +
  geom_sf(data = midwest, color = "white", alpha = 0, size = (1/6)) +
  geom_sf(data = midw_st, color = "white", size = (1/3), alpha = 0) +
  theme_icon())

p.sticker <- sticker(
  p, package="rleuven",
  p_size=8, p_y = 1.55, s_x = 1, s_y = 0.8, s_width = 1.25, s_height = 1.25,
  p_family = "google", fontface = "bold",
  h_color = "black", h_fill = "#BB0000", p_color = "gray75",
  filename="icon/hex.png"
)



