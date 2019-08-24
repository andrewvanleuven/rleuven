\name{st_dissolve}

\alias{Spatial Dissolve}

\title{Spatial Dissolve}

\description{Dissolves smaller spatial geometry into larger geometry.}

\usage{st_dissolve(df,group_var)}

\arguments{
  \item{df}{This is the dataframe you want to use. Must be in sf (simple features) format.}
  \item{group_var}{This is the variable you want to use to dissolve smaller geometries}
}

\value{A polygon or set of polygons that is composed of only the group-level. Example: all counties within the same metropolitan statistical area will be dissolved into one polygon with geometry only for said MSA.}

\author{Andrew J. Van Leuven, \email{vanleuven.3@osu.edu}}

\keyword{univar}
