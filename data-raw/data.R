# line chart -------------------------------------------------------------------
rwalk <- function(n) {
  cumsum(rnorm(n, 0, 1))
}

set.seed(12345L)

y_ <- c(rwalk(31), rwalk(31), rwalk(31), rwalk(31))
e <- runif(31 * 4, 0.5, 1.5)

tsdata <- data.frame(
  x = rep(as.Date("2025-01-01") + 0:30, times = 4),
  variable = rep(c("A", "B", "C", "D"), each = 31),
  y = y_,
  lo = y_ - e,
  hi = y_ + e
)

# bar chart --------------------------------------------------------------------
bcdata <- data.frame(
  g1 = rep(c("Jun-20", "Sep-20", "Dec-20"), each = 5),
  g2 = rep(c(
    "almost certain / a high chance", "a medium chance", "a low chance", 
    "almost no chance", "don&#39;t know"
  ), times = 3),
  value = c(
    7.1,17.9,36.3,34.7,4,5.8,16.5,36.3,37.4,3.4,4.9,13.2,36.6,42.4,2.8
  ),
  lo = c(
    6.6,17.3,35.5,33.8,3.6,5.5,15.7,35.9,36.4,3,4.5,12.6,35.8,41.5,2.5
  ),
  hi = c(
    7.5,18.6,37.1,35.5,4.4,6.2,17.2,37.8,38.5,3.7,5.3,13.8,37.5,43.4,3.2
  )
) |> dplyr::arrange(g1, g2)

# add to package ---------------------------------------------------------------
usethis::use_data(tsdata, bcdata)
