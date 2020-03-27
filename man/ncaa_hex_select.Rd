\name{ncaa_hex_select}

\alias{NCAA Hex Select}

\title{NCAA Hex Color Code Selection}

\description{Returns a hexadecimal character value of a chosen NCAA university's color code}

\usage{ncaa_hex_select(university,row_number,secondary=c('TRUE','FALSE'))}

\arguments{
  \item{university}{This is a string wich will be used as a search query for matching universities.}
  \item{row_number}{This number corresponds with the row identified in the query (using `ncaa_hex`).}
  \item{secondary}{This indicates whether to return the secondary color in the university's palette.}
}

\value{This function uses data scraped from the \href{https://teamcolorcodes.com/ncaa-color-codes/}{Team Color Codes} website to easily select colors from collegiate athletic teams.}

\author{Andrew J. Van Leuven, \email{vanleuven.3@osu.edu}}


