% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/alation.R
\name{getToken}
\alias{getToken}
\title{Get a token to use API}
\usage{
getToken(user = "", password = "", url = "")
}
\arguments{
\item{user}{Alation username.}

\item{password}{Alation password.}

\item{url}{Alation URL .}
}
\value{
An Alation token used in subsequent calls.
}
\description{
As a side effect this caches the token for other API calls to utilise
}
\examples{
\dontrun{
getToken(user="magardner",password="secret", url="https://alation.corp.ebay.com")
}

}
