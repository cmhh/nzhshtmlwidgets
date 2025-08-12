#' tsdata
#'
#' A randomly created dataset appropriate for use with `linechart`
#'
#' @format ## `tsdata`
#' A data frame with 124 rows and 60 columns:
#' \describe{
#'   \item{x}{date (x-axis data)}
#'   \item{variabe}{grouping variable for line colors}
#'   \item{y}{value (y-axis data)}
#'   \item{lo}{lower bound}
#'   \item{hi}{upper bound}
#' }
"tsdata"

#' bcdata
#'
#' A  dataset appropriate for use with `barchart`
#'
#' @format ## `bcdata`
#' A data frame with 124 rows and 60 columns:
#' \describe{
#'   \item{g1}{grouping variable}
#'   \item{g2}{outcome}
#'   \item{value}{value (bar height / count)}
#'   \item{lo}{lower bound}
#'   \item{hi}{upper bound}
#' }
"bcdata"