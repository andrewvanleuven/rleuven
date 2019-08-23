#' 2010 Population estimates for Ohio municipalities and the counties in which they are located
#'
#' Data from a the U.S. Census
#'
#' @docType data
#'
#' @usage data(ohiocities)
#'
#' @keywords datasets
#'
#' @source \href{https://www.census.gov/data/tables/time-series/demo/popest/2010s-total-cities-and-towns.html#ds}{U.S. Census}
#'
#' @examples
#' data(ohiocities)
#' countyrank <- freqTab(ohiocities, "county_name",15,noties=T)
"ohiocities"
