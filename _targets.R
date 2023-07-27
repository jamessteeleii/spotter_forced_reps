# _targets.R file
library(targets)
library(tarchetypes)
source("R/functions.R")
tar_option_set(packages = c("tidyverse", "rstan", "brms", "base", "tidybayes", "ggh4x", "broom.mixed", "quarto"))

list(
  # Load in data
  tar_target(file, "data/data forced rep study.csv", format = "file"),
  tar_target(data, get_data(file)),

  # Fit model
  tar_target(model_brms, fit_brms_model(data)),

  # Make and save plots
  tar_target(individual_data_plot, plot_individual_data(data)),
  tar_target(model_data_plot, plot_model_data(model_brms, data)),

  tar_target(trace_plots, make_trace_plots(model_brms)),
  tar_target(pp_check_plot, make_pp_check(model_brms)),
  
  # Get tidy model summary
  tar_target(tidy_model_brms, get_tidy_model(model_brms)),
  
  # Render the report
  tar_quarto(report, "report.qmd")
  
)
