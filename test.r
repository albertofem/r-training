data <- data.frame(
    countries = c("Spain", "Vizcaya"),
    gpd = c(1.2,-3),
    k = 3
)

positive_g = data$gpd > 0

data[, positive_g]