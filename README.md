# Simulation, Bootstrap Confidence Intervals, and Hypothesis Testing

## Project Overview

This repository contains the code and figure outputs for a simulation-based statistics project focused on statistical inference. The analysis uses repeated sampling and resampling to make core ideas in inference concrete: how uncertainty is estimated, how confidence intervals behave over repeated samples, and how hypothesis tests compare observed evidence against a null model.

The project assumes a population with mean 50 and standard deviation 10, then repeatedly draws samples of size 50. Using simulation, it demonstrates:

1. how a bootstrap confidence interval is constructed;
2. whether a 95% confidence procedure achieves approximately 95% coverage in repeated samples; and
3. how a hypothesis test compares an observed test statistic to a null distribution.

All analyses are implemented in R and generate plots in the `figure/` directory, along with an interactive HTML visualization that can be opened in a browser.

## Introduction

Statistical inference is about learning something about a population from a sample. Concepts such as confidence intervals and p-values can be difficult to understand from formulas alone. This project uses simulation to make those ideas more tangible.

Rather than relying only on theory, the project asks: what happens when we repeatedly generate samples and resample them? By doing so, we can connect simulation results to the logic of statistical inference.

The project uses a synthetic population with mean 50 and standard deviation 10. It repeatedly draws samples of size 50 and then uses bootstrap methods to approximate the sampling distribution of the sample mean.

## Data and Method

The project uses simulated data generated directly in R rather than an external dataset. This keeps the workflow reproducible and easy to follow.

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

The code simulates many values of Z under the null hypothesis, builds the empirical null distribution, identifies the rejection region for a two-sided 5% test, and calculates a simulated p-value for the observed statistic.

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
└── .Rproj.user/
```

### Script descriptions

- `code/analysis_1.R` generates the bootstrap distribution plot and saves `figure/bootstrap_distribution.png`.
- `code/analysis_2.R` simulates repeated confidence intervals and saves `figure/coverage_simulation.png`.
- `code/analysis_3.R` simulates the null distribution, rejection region, and p-value, and saves `figure/null_distribution.png` and `figure/p_value.png`.
- `code/interactive_bootstrap.R` creates the interactive HTML visualization saved to `figure/bootstrap_interactive.html`.

## Reproduction Instructions

### 1. Open the project in RStudio or start an R session

Open the repository in RStudio, or start an R session in the project directory. The project file `Zhengyang_Ding_AEDS6400_blog8.Rproj` is included for convenience.

### 2. Run the analysis scripts in order

From the repository root, run:

```r
source("code/analysis_1.R")
source("code/analysis_2.R")
source("code/analysis_3.R")
source("code/interactive_bootstrap.R")
```

### 3. View the outputs

The generated files are saved in the `figure/` directory:

- `bootstrap_distribution.png`
- `coverage_simulation.png`
- `null_distribution.png`
- `p_value.png`
- `bootstrap_interactive.html`

Open `figure/bootstrap_interactive.html` in a browser to explore how the bootstrap interval changes as the sample size, confidence level, number of bootstrap samples, and true mean are varied.

## Expected Interpretation

This project is intended to show that statistical inference is not just a set of formulas; it is a process that can be understood through repeated simulation. By generating many samples and resampling them, the project makes visible the logic behind confidence intervals and hypothesis tests.

The key takeaway is that simulation helps explain why a 95% confidence interval is interpreted in terms of long-run coverage and why a p-value is understood as a tail probability under the null hypothesis.

## Summary

This repository demonstrates the core ideas behind statistical inference using simulation, visualization, and interactive exploration. It is a compact, reproducible example of how bootstrap resampling and repeated sampling can be used to connect theory to intuition.

The scripts are organized for direct execution within the repository and are well-suited for GitHub-based distribution and reproducible analysis.
