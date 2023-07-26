# _targets.R file
library(targets)
source("R/functions.R")
tar_option_set(packages = c("tidyverse", "rstan", "brms", "base", "tidybayes"))

list(
  # Load in data
  tar_target(file, "data/data forced rep study.csv", format = "file"),
  tar_target(data, get_data(file)),

  # Fit model
  tar_target(model_brms, fit_brms_model(data)),
#   tar_target(classif_rsa_models, fit_classif_rsa_models(rsa_data)),
#   
#   # Get model summaries
#   tar_target(disability_rsa_summaries, get_rsa_summaries(disability_rsa_models)),
#   tar_target(classif_rsa_summaries, get_rsa_summaries(classif_rsa_models)),
#   
#   # Get model predicted values
#   tar_target(disability_rsa_predicted_values, get_disability_rsa_predicted_values(disability_rsa_models)),
#   tar_target(classif_rsa_predicted_values, get_classif_rsa_predicted_values(classif_rsa_models)),
#   
  # Make plots
  tar_target(individual_data_plot, plot_individual_data(data)),
  tar_target(trace_plots, make_trace_plots(model_brms)),
  tar_target(model_data_plot, plot_model_data(model_brms, data))
#   
)

