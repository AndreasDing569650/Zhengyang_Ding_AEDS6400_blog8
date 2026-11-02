# Simulation, Bootstrap Confidence Intervals, and Hypothesis Testing

## Project Overview

This repository contains the code and visual outputs for a simulation-based statistics blog post on statistical inference. The project is designed to make abstract ideas such as bootstrap confidence intervals, interval coverage, null distributions, rejection regions, and p-values more intuitive by repeatedly generating data and observing how sampling variability behaves.

The analysis focuses on a simple setup in which a population is assumed to have mean 50 and standard deviation 10. Using repeated sampling and resampling, the project demonstrates:

1. how a bootstrap confidence interval is constructed;
2. whether a 95% confidence procedure achieves approximately 95% coverage in repeated samples; and
3. how a hypothesis test compares an observed test statistic to a null distribution.

This project is written in R and produces a set of figures and an interactive HTML visualization that can be opened directly in a browser.

## Introduction

Statistical inference is about learning something about a population from a sample. However, ideas such as confidence intervals and p-values can be difficult to understand from formulas alone. Simulation provides an intuitive way to see how these ideas work by generating repeated samples and observing the distributions that result.

Rather than relying only on theory, this project asks: what happens when we repeatedly simulate the data-generating process? By doing so, we can visually connect the concepts of sampling variation, uncertainty, and statistical decision-making.

The project uses a population with mean 50 and standard deviation 10, then repeatedly draws samples of size 50. The resulting bootstrap distributions, coverage simulations, and null distributions provide a clear visual explanation of how inference works in practice.

## Data and Method

The project uses synthetic data generated directly in R rather than an external dataset. This makes the analysis fully reproducible and easy to understand.

### Simulation setup

For the bootstrap confidence interval analysis:

- generate a large pseudo-population from a normal distribution with mean 50 and standard deviation 10;
- draw a sample of size 50 from that population;
- repeatedly resample from the sample with replacement;
- compute the sample mean for each bootstrap sample;
- construct a 95% percentile confidence interval from the bootstrap distribution.

The key statistic is the sample mean, and the bootstrap distribution approximates the sampling distribution of that estimator.

### Coverage simulation

To evaluate the interpretation of a 95% confidence interval:

- repeat the sampling process 1,000 times;
- for each sample, construct a bootstrap confidence interval;
- record whether the interval contains the true population mean;
- calculate the empirical coverage rate.

This produces a visual summary of how often a nominal 95% interval actually captures the truth across many repeated samples.

### Hypothesis testing

For the hypothesis test, the project assumes the null hypothesis:

$$
H_0: \mu = 50
$$

and uses the standardized test statistic:

$$
Z = \frac{\bar{X} - \mu_0}{\sigma / \sqrt{n}}
$$

The code simulates many values of Z under the null hypothesis, builds the empirical null distribution, identifies the rejection region for a two-sided 5% test, and calculates a simulated p-value for a specific observed statistic.

This connects the concepts of:

- null distribution;
- tail probabilities;
- critical values and rejection regions; and
- p-values as measures of extremeness under the null hypothesis.

## Repository Structure

```text
Zhengyang_Ding_AEDS6400_blog8/
├── .gitignore
├── README.md
├── Zhengyang_Ding_AEDS6400_blog8.Rproj
├── code/
│   ├── analysis_1.R
│   ├── analysis_2.R
│   ├── analysis_3.R
│   └── interactive_bootstrap.R
├── figure/
│   ├── bootstrap_distribution.png
│   ├── bootstrap_interactive.html
│   ├── coverage_simulation.png
│   ├── null_distribution.png
│   └── p_value.png
└── .Rproj.user/   # optional local RStudio metadata
```

### Script descriptions

- `code/analysis_1.R` creates the bootstrap distribution plot and saves `figure/bootstrap_distribution.png`.
- `code/analysis_2.R` simulates repeated confidence intervals and saves `figure/coverage_simulation.png`.
- `code/analysis_3.R` simulates the null distribution, rejection region, and p-value, and saves `figure/null_distribution.png` and `figure/p_value.png`.
- `code/interactive_bootstrap.R` builds the interactive HTML visualization saved to `figure/bootstrap_interactive.html`.

## Reproduction Instructions

### 1. Open the project in RStudio

Open the R project file:

```r
open Zhengyang_Ding_AEDS6400_blog8.Rproj
```

### 2. Update the project path if needed

The script files currently include a fixed local path:

```r
project_path <- "D:/Rproject/6400-blog8"
```

If your local repository is stored in a different folder, update this line in each script so it points to the folder where this project is located on your machine.

### 3. Run the analysis scripts in order

From the repository root, run:

```r
source("code/analysis_1.R")
source("code/analysis_2.R")
source("code/analysis_3.R")
source("code/interactive_bootstrap.R")
```

### 4. View the outputs

The generated files will appear in the `figure/` directory:

- `bootstrap_distribution.png`
- `coverage_simulation.png`
- `null_distribution.png`
- `p_value.png`
- `bootstrap_interactive.html`

Open `bootstrap_interactive.html` in a browser to explore how the bootstrap interval changes as the sample size, confidence level, number of bootstrap samples, and true mean are varied.

## Expected Interpretation

This project is intended to show that statistical inference is not just a set of formulas; it is a process that can be understood through repeated simulation. By generating many samples and resampling many times, we can see how uncertainty appears in the distribution of sample means and how a confidence interval or test statistic behaves under repeated sampling.

The key takeaway is that simulation makes the logic of statistical uncertainty visible. It helps explain why a 95% confidence interval is interpreted in terms of long-run coverage, and why a p-value measures how unusual an observed result is under a null hypothesis.

## Summary

This repository demonstrates the core ideas behind statistical inference using simulation, visualization, and interactive exploration. It is a compact, reproducible example of how bootstrap resampling and null-distribution-based testing can be used to understand uncertainty in a concrete and intuitive way.
