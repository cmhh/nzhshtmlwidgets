#' Format dataset
#'
#' @param data data Data frame with three columns with two categorical variables and a single measure (count, proportion, etc.)
reshape_ctdata <- function(data) {
  v1 <- unique(data[,1])
  v2 <- unique(data[,2])

  data_ <- list()
  for(v1_ in v1) {
    x <- data[data[,1] == v1_,]
    values <- lapply(v2, \(v2_) {
      x[x[,2] == v2_, colnames(data)[3]]
    }) |> setNames(v2)

    data_[[length(data_) + 1]] <- list(outcome = v1_, values = values)
  }

  data_
}

#' Table with circles
#'
#' Table where values are represented as circles of varying size.
#'
#' @param data Data frame with three columns with two categorical variables and a single measure (count, proportion, etc.)
#' @param max_val Lower and upper values for bar track
#' @param bar_color Bar color
#' @param track_color Track color
#' @param font_color Font color
#' @param width Width
#' @param height Height
#' @param elementId Block ID
#'
#' @import htmlwidgets
#'
#' @export
#'
#' @examples
#' set.seed(1234)
#'
#' d <- data.frame(
#'   g1 = rep(c("Foo", "Bar", "Baz"), each = 3),
#'   g2 = rep(c("A", "B", "C"), 3),
#'   value = runif(9)
#' )
#'
#' circletab(d, max_value = 1)
circletab <- function(
  data,
  max_value,
  fill_color = "rgba(59, 130, 246, .5)",
  stroke_width = 2,
  stroke_color = "#333",
  width = "100%", height = "auto",
  elementId = NULL
) {
  # forward options using x
  x = list(
    data = jsonlite::toJSON(
      reshape_ctdata(data), auto_unbox = TRUE
    ) |> as.character(),
    fillColor = fill_color,
    strokeWidth = stroke_width,
    strokeColor = stroke_color
  )

  if (!missing(max_value)) x[["maxVal"]] <- max_value

  # create widget
  htmlwidgets::createWidget(
    name = 'circletab',
    x,
    width = width,
    height = height,
    package = 'nzhswidgets',
    elementId = elementId
  )
}

#' Shiny bindings for circletab
#'
#' Output and render functions for using circletab within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a circeltab
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name circletab-shiny
#'
#' @export
circletabOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(
    outputId, 'circletab', width, height, package = 'circletabR'
  )
}

#' @rdname circletab-shiny
#' @export
renderCircletab <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, circletabOutput, env, quoted = TRUE)
}
