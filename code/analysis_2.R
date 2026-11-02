# ============================================================
# Blog 8: Confidence Interval Coverage Simulation
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

population_mean <- 50
population_sd <- 10

sample_size <- 50

n_bootstrap <- 5000

n_simulations <- 1000

confidence_level <- 0.95

alpha <- 1 - confidence_level


# ============================================================
# 4. Confidence Interval Coverage Simulation
# ============================================================


# ------------------------------------------------------------
# 4.1 Set up the simulation
# ------------------------------------------------------------

coverage_results <- data.frame(
  simulation = 1:n_simulations,
  lower = numeric(n_simulations),
  upper = numeric(n_simulations),
  covered = logical(n_simulations)
)


# ------------------------------------------------------------
# 4.2 Repeat sampling and bootstrap confidence intervals
# ------------------------------------------------------------

for (i in 1:n_simulations) {
  
  # Draw a new sample
  
  sample_data <- rnorm(
    sample_size,
    mean = population_mean,
    sd = population_sd
  )
  
  
  # Bootstrap resampling
  
  bootstrap_means <- numeric(
    n_bootstrap
  )
  
  
  for (j in 1:n_bootstrap) {
    
    bootstrap_sample <- sample(
      sample_data,
      size = sample_size,
      replace = TRUE
    )
    
    bootstrap_means[j] <- mean(
      bootstrap_sample
    )
  }
  
  
  # Construct confidence interval
  
  bootstrap_ci <- quantile(
    bootstrap_means,
    probs = c(
      alpha / 2,
      1 - alpha / 2
    )
  )
  
  
  # Store confidence interval
  
  coverage_results$lower[i] <- bootstrap_ci[1]
  
  coverage_results$upper[i] <- bootstrap_ci[2]
  
  
  # Check whether the interval contains
  # the true population mean
  
  coverage_results$covered[i] <- (
    population_mean >= bootstrap_ci[1] &
      population_mean <= bootstrap_ci[2]
  )
}


# ------------------------------------------------------------
# 4.3 Calculate coverage rate
# ------------------------------------------------------------

coverage_rate <- mean(
  coverage_results$covered
)

print(coverage_rate)

cat(
  "Estimated coverage rate:",
  round(coverage_rate, 3),
  "\n"
)

cat(
  "Target confidence level:",
  confidence_level,
  "\n"
)


# ------------------------------------------------------------
# 4.4 Select 100 intervals for visualization
# ------------------------------------------------------------

set.seed(123)

plot_sample <- coverage_results[
  sample(
    1:nrow(coverage_results),
    100
  ),
]

plot_sample$plot_order <- 1:nrow(
  plot_sample
)


# ------------------------------------------------------------
# 4.5 Plot confidence interval coverage
# ------------------------------------------------------------

coverage_plot <- ggplot(
  plot_sample,
  aes(
    y = plot_order,
    xmin = lower,
    xmax = upper
  )
) +
  geom_errorbar(
    height = 0
  ) +
  geom_vline(
    xintercept = population_mean,
    linetype = "dashed",
    linewidth = 1
  ) +
  labs(
    title = "Coverage of 95% Confidence Intervals",
    subtitle = paste0(
      "Estimated coverage = ",
      round(coverage_rate * 100, 1),
      "%"
    ),
    x = "Confidence Interval for the Population Mean",
    y = "Simulation"
  ) +
  theme_minimal()


print(coverage_plot)


# Save the figure

ggsave(
  filename = file.path(
    figure_path,
    "coverage_simulation.png"
  ),
  plot = coverage_plot,
  width = 8,
  height = 6,
  dpi = 300
)
