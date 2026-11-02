# ============================================================
# Blog 8: Hypothesis Testing
# Null Distribution, Rejection Region, and p-Value
# ============================================================


# ------------------------------------------------------------
# 1. Project paths
# ------------------------------------------------------------

project_path <- if (basename(getwd()) == "code") {
  normalizePath("..", winslash = "/", mustWork = FALSE)
} else {
  normalizePath(".", winslash = "/", mustWork = FALSE)
}

figure_path <- file.path(
  project_path,
  "figure"
)

if (!dir.exists(figure_path)) {
  dir.create(
    figure_path,
    recursive = TRUE
  )
}


# ------------------------------------------------------------
# 2. Load packages
# ------------------------------------------------------------

library(ggplot2)


# ============================================================
# 3. General parameters
# ============================================================

set.seed(123)

population_sd <- 10


# ============================================================
# 4. Hypothesis Testing
# ============================================================


# ------------------------------------------------------------
# 4.1 Define the null hypothesis
# ------------------------------------------------------------

mu_null <- 50

sample_size_test <- 50

n_test_simulations <- 10000

test_alpha <- 0.05


# ------------------------------------------------------------
# 4.2 Simulate test statistics under H0
# ------------------------------------------------------------

test_statistics <- numeric(
  n_test_simulations
)


for (i in 1:n_test_simulations) {
  
  # Generate data assuming H0 is true
  
  sample_data <- rnorm(
    sample_size_test,
    mean = mu_null,
    sd = population_sd
  )
  
  
  # Calculate the sample mean
  
  sample_mean <- mean(
    sample_data
  )
  
  
  # Calculate the standardized test statistic
  
  test_statistics[i] <- (
    sample_mean - mu_null
  ) / (
    population_sd / sqrt(sample_size_test)
  )
}


# ------------------------------------------------------------
# 4.3 Store the simulated null distribution
# ------------------------------------------------------------

test_df <- data.frame(
  test_statistic = test_statistics
)


# ------------------------------------------------------------
# 4.4 Determine the rejection region
# ------------------------------------------------------------

critical_values <- quantile(
  test_statistics,
  probs = c(
    test_alpha / 2,
    1 - test_alpha / 2
  )
)

print(critical_values)


# ------------------------------------------------------------
# 4.5 Plot the null distribution
# ------------------------------------------------------------

null_distribution_plot <- ggplot(
  test_df,
  aes(x = test_statistic)
) +
  geom_histogram(
    bins = 60
  ) +
  geom_vline(
    xintercept = critical_values[1],
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = critical_values[2],
    linetype = "dashed",
    linewidth = 1
  ) +
  labs(
    title = "Simulated Distribution of the Test Statistic Under H₀",
    subtitle = "Two-sided test with α = 0.05",
    x = "Test Statistic",
    y = "Count"
  ) +
  theme_minimal()


print(null_distribution_plot)


# Save the figure

ggsave(
  filename = file.path(
    figure_path,
    "null_distribution.png"
  ),
  plot = null_distribution_plot,
  width = 8,
  height = 5,
  dpi = 300
)


# ============================================================
# 5. Simulated p-value
# ============================================================


# ------------------------------------------------------------
# 5.1 Choose an observed test statistic
# ------------------------------------------------------------

observed_test_statistic <- 2.4


# ------------------------------------------------------------
# 5.2 Calculate the simulated p-value
# ------------------------------------------------------------

p_value <- mean(
  abs(test_statistics) >=
    abs(observed_test_statistic)
)

print(p_value)


cat(
  "Observed test statistic:",
  observed_test_statistic,
  "\n"
)

cat(
  "Simulated p-value:",
  round(p_value, 4),
  "\n"
)


# ------------------------------------------------------------
# 5.3 Plot the observed statistic
# ------------------------------------------------------------

p_value_plot <- ggplot(
  test_df,
  aes(x = test_statistic)
) +
  geom_histogram(
    bins = 60
  ) +
  geom_vline(
    xintercept = critical_values[1],
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = critical_values[2],
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = observed_test_statistic,
    linewidth = 1
  ) +
  labs(
    title = "Observed Test Statistic and the Null Distribution",
    subtitle = paste0(
      "Observed statistic = ",
      observed_test_statistic,
      "; p-value = ",
      round(p_value, 4)
    ),
    x = "Test Statistic",
    y = "Count"
  ) +
  theme_minimal()


print(p_value_plot)


# Save the figure

ggsave(
  filename = file.path(
    figure_path,
    "p_value.png"
  ),
  plot = p_value_plot,
  width = 8,
  height = 5,
  dpi = 300
)
