get_data <- function(file) {
  read.csv(file, fileEncoding = 'UTF-8-BOM') %>% 
    mutate(sex = as.factor(sex),
           actual_assistance_percentage = (actual_assistance_kg / load_kg)*100,
           avg_tut_rep = tut_set/reps) %>%
    pivot_longer(c(trainee_perception_assistance, spotter_perception_assistance),
                 names_to = "role", values_to = "perception_assistance") %>%
    mutate(role = str_remove(role, "_perception_assistance"),
           id = if_else(role == "trainee", trainee_id, spotter_id))
}

plot_individual_data <- function(data) {
  
  individual_data_plot <- data %>%
    ggplot(aes(x = actual_assistance_percentage, y = perception_assistance, group=role, color=role)) +
    geom_point(position = position_jitter(width = 0.5, height = 0.5)) +
    geom_line() +
    geom_text(aes(label=forced_rep_no, y = perception_assistance+10), size = 2.5, show.legend = FALSE) +
    facet_wrap(~id, ncol = 9) +
    scale_color_brewer(palette = "Dark2") +
    scale_x_continuous(breaks = c(0,25,50,75,100)) +
    scale_y_continuous(breaks = c(0,25,50,75,100)) +
    labs(x = "Actual Assistance Provided (%)",
         y = "Perception of Assistance Provided (%)",
         color = "Role",
         title = "Individual Participant Data",
         subtitle = "Note, the labels indicate which forced repetition number each point corresponds to") +
    theme_bw() +
    theme(legend.position = "bottom")
  
  individual_data_plot
  
  ggsave("plots/individual_data_plot.tiff", width = 10, height = 10, device = "tiff", dpi = 300)
  
}

fit_brms_model <- function(data) {
  
  # run rstan quicker - for bayesian beta regression later on
  rstan_options(auto_write = TRUE)
  options(mc.cores = parallel::detectCores()-1)
  
  
  model_brms <- brm(perception_assistance ~ actual_assistance_percentage * role + forced_rep_no + actual_assistance_percentage:forced_rep_no +
                      (actual_assistance_percentage * role + forced_rep_no + actual_assistance_percentage:forced_rep_no | id),
                    data=data,
                    chains = 4,
                    iter = 3000, warmup = 1000,
                    cores = 4,
                    control = list(adapt_delta = 0.95), init = 0)
  
}

make_trace_plots <- function(model_brms) {
  plot(model_brms)
}


plot_model_data <- function(model_brms, data) {
  posterior_epred_draws <- crossing(actual_assistance_percentage = seq(from = 0, to = max(data$actual_assistance_percentage), length = max(data$actual_assistance_percentage)),
                                    id = unique(data$id),
                                    role = unique(data$role),
                                    forced_rep_no = unique(data$forced_rep_no)) %>%
    add_epred_draws(model_brms, re_formula = NULL) 
  
  model_data_plot <- posterior_epred_draws %>%
    mutate(rep_label = "Forced Repetition Number") %>%
    ggplot(aes(x = actual_assistance_percentage, y = .epred, color=role, fill=role)) +
    geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
    stat_lineribbon(aes(y = .epred), .width = .95, alpha = 0.25, show.legend=TRUE) +
    scale_fill_brewer(palette = "Set2") +
    scale_color_brewer(palette = "Dark2") +
    scale_x_continuous(breaks = c(0,25,50,75,100)) +
    scale_y_continuous(breaks = c(0,25,50,75,100)) +
    facet_grid(.~rep_label + forced_rep_no) +
    labs(
      title = "Expectationof the Posterior Predictive Distribution",
      subtitle = "Mean and 95% credible interval (CI)",
      x = "Actual Assistance Provided (%)",
      y = "Perception of Assistance Provided (%)",
      color = "Role", fill = "Role") +
    theme_bw() + 
    theme(panel.grid=element_blank())
  
  model_data_plot
  
  ggsave("plots/model_data_plot.tiff", width = 10, height = 7.5, device = "tiff", dpi = 300)
  
}
