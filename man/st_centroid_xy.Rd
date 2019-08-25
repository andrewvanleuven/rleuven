\name{st_centroid_xy}

\alias{Spatial Centroid XY}

\title{Spatial Centroid X and Y}

\description{Creates two columns in a simple features (sf) data frame that correspond to the X and Y coordinates of the geometry/polygon.}

\usage{st_dissolve(df,group_var)}

\arguments{
  \item{df}{This is the dataframe you want to use. Must be in sf (simple features) format.}
}

\value{This function uses the already exisitng st_centroid function, but instead of creating a column with a two-value vector, it creates two columns. These two columns pertain to the X and Y coordinates of the generated geometric centroid.}

\author{Andrew J. Van Leuven, \email{vanleuven.3@osu.edu}}

\keyword{univar}
