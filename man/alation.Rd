% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/alation.R
\docType{package}
\name{alation}
\alias{alation}
\title{Alation package}
\description{
Package to connect to Alation API
}
\details{
See the \href{https://github.com/mattwg/alation}{README} on GitHub
}
\examples{
\dontrun{
getToken(user="magardner",password="secret", url="https://alation.corp.ebay.com")
df <- getResult(12345)
sql <- getQuery(123456)
}
}
\references{
http://alation.com
}
\author{
Matt Gardner \email{magardner@ebay.com}
}
