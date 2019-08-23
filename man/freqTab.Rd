\name{freqTab}

\alias{Frequency Table}

\title{Frequency Table}

\description{Create a frequency table of unique values in a data column.}

\usage{freqTab(df,var,maxvals,noties)}

\arguments{
  \item{df}{This is the dataframe you want to use}
  \item{var}{This is the variable you want to look at the frequency of}
  \item{maxvals}{This is the maximum number of unique values you want to return (useful if there are dozens or hundreds of unique values in a column). If maxvals = n, and there is a tie for the number of observations in the nth largest unique value, then both values will be returned.}
  \item{noties}{This states whether the function should return exactly N rows or all of the values in the top N rankings (i.e., includes possibility of multiple rows that are tied for Nth place).}
}

\value{A frequency table listing the number of instances each unique value is in a data column, along with each value's percentage of the total.}

\author{Andrew J. Van Leuven, \email{vanleuven.3@osu.edu}}

\keyword{univar}
