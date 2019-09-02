\name{rand_ncolors}

\alias{Random N Colors}

\title{Random Discrete Color Palette}

\description{Uses a data frame to create a vector of random color codes (one per row of data frame). This function uses a function created by Jason C Fisher at the United States Geological Survey (USGS).}

\usage{rand_ncolors(df)}

\arguments{
  \item{df}{This is the dataframe you want to use. Number of colors generated (i.e., length of char. vector) is the number of rows that df has.}
}

\value{This function generates a character vector of hexadecimal color codes. This vector is then randomized using the sample function. Maximum of n is 256.}

\author{Andrew J. Van Leuven, \email{vanleuven.3@osu.edu}}

\keyword{univar}
