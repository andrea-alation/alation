#' Alation package
#'
#' Package to connect to Alation API
#'
#' See the \href{https://github.com/mattwg/alation}{README} on GitHub
#'
#' @docType package
#' @name alation
#' @author Matt Gardner \email{magardner@@ebay.com}
#' @references http://alation.com
#' @examples
#' \dontrun{
#' getToken(user="magardner",password="secret", url="https://alation.corp.ebay.com")
#' df <- getResult(12345)
#' sql <- getQuery(123456)
#' }
NULL

#' Get a token to use API 
#'
#' As a side effect this caches the token for other API calls to utilise
#' 
#' @param user Alation username.
#' @param password Alation password.
#' @param url Alation URL .
#' @return An Alation token used in subsequent calls.
#' @examples
#' \dontrun{
#' getToken(user="magardner",password="secret", url="https://alation.corp.ebay.com")
#' }
#'
getToken <- function(user="", password="", url="")
{
  cat("\014")
  
  if(!is.character(user)) {
    stop("user must be a chracter string")
  }
  if(!is.character(password)) {
    stop("password must be a character string")
  }
  if(!is.character(url)) {
    stop("url must be a character string")
  }
  if(user=="") {
    stop("user must be a character string")
  }
  if(password=="") {
    stop("password must be a character string")
  }
  if(url=="") {
    stop("url must be a character string")
  }
  if (length(user)!=1) {
    stop("user cannot be a vector")
  }
  if (length(password)!=1) {
    stop("password cannot be a vector")
  }
  if (length(url)!=1) {
    stop("url cannot be a vector")
  }
  
  if (!require("RCurl",quietly = TRUE)) {
    stop("RCurl package required to connect to Alation.", call. = FALSE)
  }
  
  api <- paste(url,'/api/getToken/',sep='')
  data <- paste('Username=',URLencode(user,reserved=TRUE),'&Password=',URLencode(password,reserved=TRUE),sep='')
  
  result <- tryCatch({
    resp <- getURL(url=api, .opts = list(postfields=data, ssl.verifypeer = FALSE) )
  }, warning = function(w) {
    print(w)
  }, error = function(e) {
    print(e)
  })
  
  
  if( result == "EXISTING"){
    cat("Token already exists - to update your token use changeToken().\n")
    return(NULL)
  }
  
  if( result == "INVALID"){
    cat("Could not create token - check your credentials.\n")
    return(NULL)
  }
  
  path <- path.package("alation")
  f <- paste(path,"/.token",sep="")
  token <- result
  save(token,url,file=f)
  cat("Initialised successfully\n")
  
  return(result);
  
}

#' Get a token to use API 
#'
#' As a side effect this caches the token for other API calls to utilise
#' 
#' @param user Alation username.
#' @param password Alation password.
#' @param url Alation URL .
#' @return An Alation token used in subsequent calls.
#' @examples
#' \dontrun{
#' storeToken(token="aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa", url="https://alation.corp.ebay.com")
#' }
#'
storeToken <- function(token="", url="")
{
  cat("\014")
  
  if(!is.character(token)) {
    stop("token must be a chracter string")
  }
  if(!is.character(url)) {
    stop("url must be a character string")
  }
  if(token=="") {
    stop("token must be a character string")
  }
  if(url=="") {
    stop("url must be a character string")
  }
  if (length(token)!=1) {
    stop("token cannot be a vector")
  }
  if (length(url)!=1) {
    stop("url cannot be a vector")
  }
  
  path <- path.package("alation")
  f <- paste(path,"/.token",sep="")
  save(token,url,file=f)
  cat("Initialised successfully\n")
  
}

#' Change token to use API 
#'
#' As a side effect this caches the token for other API calls to utilise
#' 
#' @param user Alation username.
#' @param password Alation password.
#' @param url Alation URL.
#' @return An Alation token used in subsequent calls.
#' @examples
#' \dontrun{
#' changeToken(user="magardner",password="secret", url="https://alation.corp.ebay.com")
#' }
#'
changeToken <- function(user="", password="", url="") {
  cat("\014")
  
  if(!is.character(user)) {
    stop("user must be a chracter string")
  }
  if(!is.character(password)) {
    stop("password must be a character string")
  }
  if(!is.character(url)) {
    stop("url must be a character string")
  }
  if(user=="") {
    stop("user must be a character string")
  }
  if(password=="") {
    stop("password must be a character string")
  }
  if(url=="") {
    stop("url must be a character string")
  }
  if (length(user)!=1) {
    stop("user cannot be a vector")
  }
  if (length(password)!=1) {
    stop("password cannot be a vector")
  }
  if (length(url)!=1) {
    stop("url cannot be a vector")
  }
  
  if (!require("RCurl",quietly = TRUE)) {
    stop("RCurl package required to connect to Alation.", call. = FALSE)
  }
  
  api <- paste(url,'/api/changeToken/',sep='')
  data <- paste('Username=',URLencode(user,reserved=TRUE),'&Password=',URLencode(password,reserved=TRUE),sep='')
  
  result <- tryCatch({
    resp <- getURL(url=api, .opts = list(postfields=data, ssl.verifypeer = FALSE))
  }, warning = function(w) {
    print(w)
  }, error = function(e) {
    print(e)
  })
  

  if( result == "INVALID"){
    cat("Could not create token - check your credentials.\n")
    return(NULL)
  }
  
  path <- path.package("alation")
  f <- paste(path,"/.token",sep="")
  token <- result
  save(token,url,file=f)   
  cat("Initialised successfully\n")
  
  return(result)
}

#' Get query from Alation
#'
#' @param id Alation Query ID
#' @return The query as a character object
#' @examples
#' \dontrun{
#' sql <- getQuery(123456)
#' }
#'
getQuery <- function(id)
{
  if(id == "" ) {
    stop("A valid Alation query id is required")
  }
  if (id != as.integer(id))
  {
    stop("The query_id must be an integer")
  }
  
  if (!require("RCurl",quietly = TRUE)) {
    stop("RCurl package required to connect to Alation.", call. = FALSE)
  }
  
  path <- path.package("alation")
  f <- paste(path,"/.token",sep="")
  
  if(!file.exists(f)) {
    stop("You need an Alation token before calling getQuery() - see getToken() for details.")
  }
  load(f)
  
  header <- basicTextGatherer()
  u <- paste(url, "/api/query/",id,"/sql/",sep="")
  opts <- list(httpheader="Content-Type: application/json", httpheader=paste("token: ",token,sep=""), ssl.verifypeer = FALSE)
  r <- getURL(u,.opts=opts, headerfunction = header$update)    
  h <- parseHTTPHeader( header$value() )
  if (! ( h["status"] >= 200 && h["status"] < 300 ) ) {
      stop(paste("HTTP error : ", h["status"]," ",h["statusMessage"],". Check the query_id is valid.",sep=""))
  }
  r
}

#' Get result from Alation
#'
#' @param id Alation Result ID
#' @return The result as a data frame
#' @examples
#' \dontrun{
#' df <- getResult(12345)
#' }
#'
getResult <- function(id)
{
  if(id == "" ) {
    stop("A valid Alation result id is required")
  }
  if (id != as.integer(id))
  {
    stop("The id must be an integer")
  }
  
  if (!require("RCurl",quietly = TRUE)) {
    stop("RCurl package required to connect to Alation.", call. = FALSE)
  }
  
  path <- path.package("alation")
  f <- paste(path,"/.token",sep="")
  
  if(!file.exists(f)) {
    stop("You need an Alation token before calling getResult() - see getToken() for details.")
  }
  load(f)
  
  header <- basicTextGatherer()
  u <- paste(url, "/api/result/",id,"/csv/",sep="")
  opts <- list(httpheader="Content-Type: application/json", httpheader=paste("token: ",token,sep=""),  ssl.verifypeer = FALSE)
  r <- getURL(u,.opts=opts, headerfunction = header$update)    
  h <- parseHTTPHeader( header$value() )
  if (! ( h["status"] >= 200 && h["status"] < 300 ) ) {
    stop(paste("HTTP error : ", h["status"]," ",h["statusMessage"],". Check the result_id is valid.",sep=""))
  }
  read.csv(textConnection(r))
}

#' Get latest result id from Alation
#'
#' @param id Alation Query ID for which you want the most recent execution
#' @return The result id
#' @examples
#' \dontrun{
#' df <- getLatestResultID(123456)
#' }
#'
getLatestResultID <- function(id)
{
  if(id == "" ) {
    stop("A valid Alation result id is required")
  }
  if (id != as.integer(id))
  {
    stop("The id must be an integer")
  }
  
  if (!require("RCurl",quietly = TRUE)) {
    stop("RCurl package required to connect to Alation.", call. = FALSE)
  }
  
  path <- path.package("alation")
  f <- paste(path,"/.token",sep="")
  
  if(!file.exists(f)) {
    stop("You need an Alation token before calling getResult() - see getToken() for details.")
  }
  load(f)
  
  header <- basicTextGatherer()
  u <- paste(url, "/integration/v1/query/",id,"/result/latest/",sep="")
  opts <- list(httpheader="Content-Type: application/json", httpheader=paste("token: ",token,sep=""),  ssl.verifypeer = FALSE)
  r <- getURL(u,.opts=opts, headerfunction = header$update)  
  h <- parseHTTPHeader( header$value() )
  if (! ( h["status"] >= 200 && h["status"] < 300 ) ) {
    stop(paste("HTTP error : ", h["status"]," ",h["statusMessage"],". Check the query_id is valid.",sep=""))
  }
  if (!require("jsonlite",quietly = TRUE)) {
    stop("jsonlite package required to connect to parse output", call. = FALSE)
  }
  result_id <- fromJSON(r)$id
}

#' Get latest result from Alation
#'
#' @param id Alation Query ID for which you want the most recent execution
#' @return The result as a data frame
#' @examples
#' \dontrun{
#' df <- getLatestResult(123456)
#' }
#'
getLatestResult <- function(id)
{
  result_id <- getLatestResultID(id)
  getResult(result_id)
}


