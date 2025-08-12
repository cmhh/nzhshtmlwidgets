data <- data.frame(
  g1 = rep(c("Jun-20", "Sep-20", "Dec-20"), each = 5),
  g2 = rep(c(
    "almost certain / a high chance", "a medium chance", "a low chance", 
    "almost no chance", "don&#39;t know"
  ), times = 3),
  value = c(7.1,17.9,36.3,34.7,4,5.8,16.5,36.3,37.4,3.4,4.9,13.2,36.6,42.4,2.8),
  lo = c(6.6, 17.3, 35.5, 33.8, 3.6, 5.5, 15.7, 35.9, 36.4, 3, 4.5, 12.6, 35.8, 41.5, 2.5),
  hi = c(7.5, 18.6, 37.1, 35.5, 4.4, 6.2, 17.2, 37.8, 38.5, 3.7, 5.3, 13.8, 37.5, 43.4, 3.2)
) |> dplyr::arrange(g1, g2)


data <- data.frame(
  x = rep(c("Dec-05", "Mar-06", "Jun-06"), times = 2),
  variable = rep(c("A", "B"), each = 3),
  y = c(3,2,1,1,2,3),
  lo = c(2.5, 1.5, 0.5, 0.5, 1.5, 2.5),
  hi = c(3.5, 2.5, 1.5, 1.5, 2.5, 3.5)
)

linechart(data)

nzhswidgets:::reshape_bcdata(data)$categories |> jsonlite::toJSON()

library(nzhswidgets)
barchart(data, height = 400, title = "x")

barchart(data[data$g2 == "Jun-20",], height = 400, title = "x", ylab = "Percent", xlab = "blah")
