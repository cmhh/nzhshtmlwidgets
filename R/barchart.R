#' Format dataset
#'
#' @param data data Data frame with three columns with two categorical variables and a single measure (count, proportion, etc.)
reshape_bcdata <- function(data) {
  x1 <- data[,1] |> unique()
  x2 <- data[,2] |> unique()
  
  series <- lapply(x1, \(x) {
    data_ <- data[data[,1] == x,]
    
    if (ncol(data_) > 3) {
      r = lapply(1:nrow(data_), \(i) {list(data_[i, 4], data_[i, 5])})
      list(name = x, data = data_[,3], range = r)
    } else {
      list(name = x, data = data_[,3])
    }
  })
  
  list(categories = x2, series = series)
}

#' Bar chart
#'
#' @param data Data frame containing data to plot
#' @param title chart title
#' @param magnitude 0 for counts, 3 for thousands, etc.
#' @param xlab x-axis label
#' @param ylab y-axis label
#' @param source_description text for data source
#' @param source_url url for data source
#' @param palette bar colours
#' @param patterns bar patterns
#' @param width Width
#' @param height Height
#' @param elementId Block ID
#'
#' @import htmlwidgets
#'
#' @export
#'
#' @examples
#' ""
barchart <- function(
  data,
  title,
  magnitude,
  xlab, 
  ylab,
  source_description, 
  source_url,
  palette,
  patterns,
  width = "100%", height = "auto",
  elementId = NULL
) {
  data_ <- reshape_bcdata(data)
  
  x = list(
    series = jsonlite::toJSON(
      data_$series, auto_unbox = TRUE
    ) |> as.character(),
    categories = jsonlite::toJSON(
      data_$categories
    ) |> as.character()
  )

  if (!missing(title)) x[["maxVal"]] <- title
  if (!missing(magnitude)) x[["magnitude"]] <- magnitude
  if (!missing(xlab)) x[["xlab"]] <- xlab
  if (!missing(ylab)) x[["ylab"]] <- ylab
  if (!missing(source_description)) x[["sourceDescription"]] <- source_description
  if (!missing(source_url)) x[["sourceUrl"]] <- source_url
  if (!missing(palette)) x[["palette"]] <- palette
  if (!missing(patterns)) x[["patterns"]] <- patterns
  if (!missing(height)) x[["height"]] <- height
  if (!missing(width)) x[["width"]] <- width

  # create widget
  htmlwidgets::createWidget(
    name = 'barchart',
    x,
    width = width,
    height = height,
    package = 'nzhswidgets',
    elementId = elementId
  )
}

#' Shiny bindings for barchart
#'
#' Output and render functions for using barchart within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a barchart
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name barchart-shiny
#'
#' @export
barchartOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(
    outputId, 'barchart', width, height, package = 'nzhswidgets'
  )
}

#' @rdname barchart-shiny
#' @export
renderBarchart <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } 
  htmlwidgets::shinyRenderWidget(expr, barchartOutput, env, quoted = TRUE)
}
