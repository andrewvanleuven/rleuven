theme_map <- function(f = 'Roboto Condensed',s = 16, oklahoma = NULL){
  g <- guides(fill = guide_colourbar(barheight = 0.35, barwidth = 15, title.position='top'))
  if(missing(oklahoma)) {
    th <- list(
      theme_void(base_family = f, base_size = s),
      theme(plot.subtitle = element_text(hjust = .5),
            plot.title = element_text(face = 'bold',hjust = .5),
            legend.title = element_text(hjust = .5,size = 10),
            legend.direction = 'horizontal'), g)
    th
  } else {
    th <- list(
      theme_void(base_family = f, base_size = s),
      theme(plot.subtitle = element_text(hjust = .5),
            plot.title = element_text(face = 'bold',hjust = .5),
            legend.title = element_text(hjust = .5,size = 10),
            legend.position = c(.175,.5),
            legend.direction = 'horizontal'), g)
    th
  }
}

