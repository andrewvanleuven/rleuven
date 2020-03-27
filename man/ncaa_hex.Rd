\name{ncaa_hex}

\alias{NCAA Hex}

\title{NCAA Hex Color Codes}

\description{Returns a tibble of NCAA university color codes}

\usage{ncaa_hex(university,secondary=c('TRUE','FALSE'))}

\arguments{
  \item{university}{This is a string wich will be used as a search query for matching universities.}
  \item{secondary}{This indicates whether to return the secondary color in the university's palette.}
}

\value{This function uses data scraped from the \href{https://teamcolorcodes.com/ncaa-color-codes/}{Team Color Codes} website to easily identify colors from collegiate athletic teams.}

\author{Andrew J. Van Leuven, \email{vanleuven.3@osu.edu}}


