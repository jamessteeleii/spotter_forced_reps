get_data <- function(file) {
  read.csv("data/data forced rep study.csv") %>%
    mutate(sex = as.factor(sex))
}

