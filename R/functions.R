get_data <- function(file) {
  read.csv("data/data forced rep study.csv") %>%
  mutate(sex = as.factor(sex),
         actual_assistance_percentage = (actual_assistance_kg / load_kg)*100, # kept on % scale to aid coefficient interpretation
         avg_tut_rep = tut_set/reps) %>% 
    pivot_longer(c(trainee_perception_assistance, spotter_perception_assistance),
                 names_to = "role", values_to = "perception_assistance") %>%
    mutate(role = str_remove(role, "_perception_assistance"),
           id = if_else(role == "trainee", trainee_id, spotter_id),
           perception_assistance = perception_assistance/100, # scaled to (0,1) to use beta regression
           rep_label = "Forced Repetition Number")
}

plot_individual_data <- function(data) {
  
  individual_data_plot <- data %>%
    ggplot(aes(x = actual_assistance_percentage, y = perception_assistance*100, group=role, color=role)) +
    geom_point(position = position_jitter(width = 0.5, height = 0.5)) +
    geom_line(alpha=0.75) +
    geom_text(aes(label=forced_rep_no, y = (perception_assistance*100)+10), size = 2.5, show.legend = FALSE) +
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
  
}

fit_brms_model <- function(data) {
  
  data <- data %>%
    mutate(forced_rep_no = forced_rep_no-1.5) # centred to aid interpretation of actual assistance slope
  
  # run rstan quicker - for bayesian beta regression later on
  rstan_options(auto_write = TRUE)
  options(mc.cores = parallel::detectCores()-1)
  
  
  model_brms <- model_brms <- brm(perception_assistance ~ actual_assistance_percentage + role + forced_rep_no + 
                                    actual_assistance_percentage:role + actual_assistance_percentage:forced_rep_no + role:forced_rep_no +
                                    (actual_assistance_percentage + role + forced_rep_no + 
                                       actual_assistance_percentage:role + actual_assistance_percentage:forced_rep_no + role:forced_rep_no | id),
                                  data = data,
                                  seed = 1988,
                                  family = Beta(),
                                  # prior = prior,
                                  chains = 4,
                                  iter = 8000, warmup = 4000,
                                  cores = 4,
                                  control = list(adapt_delta = 0.99, max_treedepth = 12), 
                                  init = 0)
  
}

make_rhat_plot <- function(model_brms) {
  mod_rhat <- enframe(brms::rhat(model_brms)) %>%
    filter(!str_detect(name, "^r_id"))
  
  rhat_main_params <- mod_rhat$value
  
  mcmc_rhat(rhat_main_params) +
    scale_x_continuous(breaks = c(1,1.01,1.02,1.03,1.04,1.05)) +
    geom_vline(xintercept = 1.01, linetype="dashed", alpha = 0.25)
}

make_trace_plots <- function(model_brms) {
  plot(model_brms)
}

make_pp_check <- function(model_brms) {
  pp_check(model_brms)
}

plot_model_data <- function(model_brms, data) {
  posterior_epred_draws <- crossing(actual_assistance_percentage = seq(from = 0, to = max(data$actual_assistance_percentage), length = max(data$actual_assistance_percentage)),
                                    id = unique(data$id),
                                    role = unique(data$role),
                                    forced_rep_no = c(-0.5,0.5)) %>%
    add_epred_draws(model_brms, re_formula = NA, ndraws = 4000) 
  
  model_data_plot <- posterior_epred_draws %>%
    mutate(rep_label = "Forced Repetition Number",
           forced_rep_no = if_else(forced_rep_no == -0.5, 1, 2)) %>%
    ggplot(aes(x = actual_assistance_percentage, y = .epred*100, color=role, fill=role)) +
    geom_abline(intercept = 0, slope = 1, linetype = "dashed") +
    geom_point(data=data, aes(x = actual_assistance_percentage, y = perception_assistance*100, color=role, fill=role),
               position = position_jitter(width = 0.5, height = 0.5), alpha=0.75) +
    stat_lineribbon(aes(y = .epred*100), .width = .95, alpha = 0.25, show.legend=TRUE) +
    scale_fill_brewer(palette = "Set2") +
    scale_color_brewer(palette = "Dark2") +
    scale_x_continuous(breaks = c(0,25,50,75,100)) +
    scale_y_continuous(breaks = c(0,25,50,75,100)) +
    facet_nested(.~rep_label + forced_rep_no) +
    labs(
      title = "Expectation of the Posterior Predictive Distribution",
      subtitle = "Global grand mean and 95% credible interval (CI)",
      x = "Actual Assistance Provided (%)",
      y = "Perception of Assistance Provided (%)",
      color = "Role", fill = "Role") +
    theme_bw() + 
    theme(panel.grid=element_blank())
  
}

get_tidy_model <- function(model_brms) {
  tidy(model_brms) %>%
    mutate(estimate = plogis(estimate)*100,
           std.error = plogis(std.error)*100, 
           conf.low = plogis(conf.low)*100, 
           conf.high = plogis(conf.high)*100) # transform coefficients from logit back to the % scale
}

plot_marg_effs <- function(model_brms, data) {
  dat <- datagrid(actual_assistance_percentage = seq(from=0, to=100, length=11),
                  role = unique(data$role),
                  forced_rep_no = c(-0.5,0.5),
                  model = model_brms) 
  
  marg_effs <- slopes(model_brms,
                      variables="actual_assistance_percentage",
                      newdata = dat,
                      re_formula = NA) %>%
    posterior_draws() 
  
  marg_effs_plot <- marg_effs %>%
    mutate(rep_label = "Forced Repetition Number",
           forced_rep_no = if_else(forced_rep_no == -0.5, 1, 2),
           actual_assistance_percentage = factor(actual_assistance_percentage)) %>%
    ggplot(aes(x = actual_assistance_percentage, y = draw*100, color=role, fill=role)) +
    geom_hline(yintercept = 1, linetype = "dashed") +
    stat_pointinterval(.width = .95, alpha = 0.75, position = position_dodge(width = 0.2),
                      size=1) +
    scale_fill_brewer(palette = "Set2") +
    scale_color_brewer(palette = "Dark2") +
    facet_nested(.~rep_label + forced_rep_no) +
    labs(
      title = "Average Marginal Effects (i.e., Slopes) for the Expectation of the Posterior Predictive Distribution",
      subtitle = "Global grand mean and 95% credible interval (CI)",
      x = "Actual Assistance Provided (%)",
      y = "Marginal Effect of Actual Assistance Provided (%)",
      color = "Role", fill = "Role") +
    theme_bw() + 
    theme(panel.grid=element_blank())
}

make_individual_data_plot_tiff <- function(individual_data_plot) {
  
  ggsave("plots/individual_data_plot.tiff", individual_data_plot, width = 10, height = 10, device = "tiff", dpi = 300)
  
}

make_model_data_plot_tiff <- function(model_data_plot) {
  
  ggsave("plots/model_data_plot.tiff", model_data_plot, width = 10, height = 5, device = "tiff", dpi = 300)
  
}

make_marg_effs_plot_tiff <- function(marg_effs_plot) {
  
  ggsave("plots/marg_effs_plot.tiff", marg_effs_plot, width = 10, height = 5, device = "tiff", dpi = 300)
  
}