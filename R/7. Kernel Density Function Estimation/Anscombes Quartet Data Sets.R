#Anscombe's Quartet is a famous example that demonstrates how different datasets
#can have identical or nearly identical statistical properties
#, such as means and variances, but exhibit different patterns when visualized.
# Create the data frames for Anscombe's Quartet
data_set_a <- data.frame(
  x = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
  y = c(8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26, 10.84, 4.82, 5.68)
)

data_set_b <- data.frame(
  x = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
  y = c(9.14, 8.14, 8.74, 8.77, 9.26, 8.10, 6.13, 3.10, 9.13, 7.26, 4.74)
)

data_set_c <- data.frame(
  x = c(10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5),
  y = c(7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73)
)

data_set_d <- data.frame(
  x = c(8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8),
  y = c(6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.50, 5.56, 7.91, 6.89)
)

# Function to calculate sample mean, variance, and correlation
stats_summary <- function(df) {
  mean_x <- mean(df$x)
  mean_y <- mean(df$y)
  var_x <- var(df$x)
  var_y <- var(df$y)
  correlation <- cor(df$x, df$y)
  
  cat("Sample Mean (x):", mean_x, "\n")
  cat("Sample Mean (y):", mean_y, "\n")
  cat("Sample Variance (x):", var_x, "\n")
  cat("Sample Variance (y):", var_y, "\n")
  cat("Correlation:", correlation, "\n")
}

# Function to calculate regression coefficients
regression_coefficients <- function(df) {
  fit <- lm(y ~ x, data = df)
  coef_intercept <- coef(fit)[1]
  coef_slope <- coef(fit)[2]
  
  cat("Regression Coefficients:\n")
  cat("Intercept:", coef_intercept, "\n")
  cat("Slope:", coef_slope, "\n")
}

# Calculate and display summary statistics for each dataset
cat("Data Set A:\n")
stats_summary(data_set_a)
regression_coefficients(data_set_a)
cat("\n")

cat("Data Set B:\n")
stats_summary(data_set_b)
regression_coefficients(data_set_b)
cat("\n")

cat("Data Set C:\n")
stats_summary(data_set_c)
regression_coefficients(data_set_c)

# Plotting the data sets
par(mfrow = c(2, 2))  # Set up a 2x2 grid of plots

# Scatter plots with fitted lines
plot(data_set_a, main = "Data Set A", xlab = "x", ylab = "y")
abline(lm(y ~ x, data = data_set_a), col = "red")

plot(data_set_b, main = "Data Set B", xlab = "x", ylab = "y")
abline(lm(y ~ x, data = data_set_b), col = "red")

plot(data_set_c, main = "Data Set C", xlab = "x", ylab = "y")
abline(lm(y ~ x, data = data_set_c), col = "red")

plot(data_set_d, main = "Data Set D", xlab = "x", ylab = "y")
abline(lm(y ~ x, data = data_set_d), col = "red")

cat("Data Set D:\n")
stats_summary(data_set_d)
regression_coefficients(data_set_d)

#Although the statistical measures are the same, the datasets exhibit different patterns when plotted.
#Each dataset has a unique relationship between the x and y variables, leading to different shapes and trends.
#This demonstrates the importance of visualizing data and not relying solely on summary statistics
#to understand the underlying patterns and relationships.