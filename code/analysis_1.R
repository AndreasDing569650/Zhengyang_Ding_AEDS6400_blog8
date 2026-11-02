# ============================================================
# Blog 8: Bootstrap Confidence Interval
# ============================================================


# ------------------------------------------------------------
# 1. Project paths
# ------------------------------------------------------------

project_path <- "D:/Rproject/6400-blog8"

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

population_mean <- 50
population_sd <- 10

sample_size <- 50

n_bootstrap <- 5000

confidence_level <- 0.95


# ============================================================
# 4. Bootstrap Confidence Interval
# ============================================================

# Generate a large population

population <- rnorm(
  100000,
  mean = population_mean,
  sd = population_sd
)


# Draw one sample from the population

sample_data <- sample(
  population,
  size = sample_size,
  replace = FALSE
)


# Calculate the sample mean

sample_mean <- mean(
  sample_data
)

print(sample_mean)


# ------------------------------------------------------------
# 4.1 Repeated bootstrap resampling
# ------------------------------------------------------------

bootstrap_means <- numeric(
  n_bootstrap
)


for (i in 1:n_bootstrap) {
  
  bootstrap_sample <- sample(
    sample_data,
    size = sample_size,
    replace = TRUE
  )
  
  bootstrap_means[i] <- mean(
    bootstrap_sample
  )
}


# ------------------------------------------------------------
# 4.2 Construct the confidence interval
# ------------------------------------------------------------

alpha <- 1 - confidence_level

bootstrap_ci <- quantile(
  bootstrap_means,
  probs = c(
    alpha / 2,
    1 - alpha / 2
  )
)

print(bootstrap_ci)


# ------------------------------------------------------------
# 4.3 Store bootstrap results
# ------------------------------------------------------------

bootstrap_df <- data.frame(
  bootstrap_mean = bootstrap_means
)


# ------------------------------------------------------------
# 4.4 Plot bootstrap distribution
# ------------------------------------------------------------

bootstrap_plot <- ggplot(
  bootstrap_df,
  aes(x = bootstrap_mean)
) +
  geom_histogram(
    bins = 40
  ) +
  geom_vline(
    xintercept = sample_mean,
    linewidth = 1
  ) +
  geom_vline(
    xintercept = bootstrap_ci[1],
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = bootstrap_ci[2],
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    xintercept = population_mean,
    linetype = "dotted",
    linewidth = 1
  ) +
  labs(
    title = "Bootstrap Distribution of the Sample Mean",
    subtitle = paste0(
      round(confidence_level * 100),
      "% Bootstrap Confidence Interval"
    ),
    x = "Bootstrap Sample Mean",
    y = "Count"
  ) +
  theme_minimal()


print(bootstrap_plot)


# Save the figure

ggsave(
  filename = file.path(
    figure_path,
    "bootstrap_distribution.png"
  ),
  plot = bootstrap_plot,
  width = 8,
  height = 5,
  dpi = 300
)