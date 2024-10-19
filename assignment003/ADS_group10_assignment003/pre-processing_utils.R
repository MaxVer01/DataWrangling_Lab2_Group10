library(tidyverse)
library(fastDummies)

# File contains all data pre-processing functions



df_as_numeric <- function(study_df) {
  #' Return our specific dataset suitable as only numeric values
  #'
  #'
  train_apt_linear <- study_df |>
    mutate(
      school = ifelse(school == "GP", 1, 0),
      sex = ifelse(sex == "F", 1, 0),
      address = ifelse(address == "U", 1, 0),
      famsize = ifelse(famsize == "GT3", 1, 0),
      Pstatus = ifelse(Pstatus == "T", 1, 0),
      Mjob_health = ifelse(Mjob == "health", 1, 0),
      Mjob_athome = ifelse(Mjob == "at_home", 1, 0),
      Mjob_teacher = ifelse(Mjob == "teacher", 1, 0),
      Mjob_services = ifelse(Mjob == "services", 1, 0),
      Mjob_other = ifelse(Mjob == "other", 1, 0),
      Fjob_health = ifelse(Fjob == "health", 1, 0),
      Fjob_athome = ifelse(Fjob == "at_home", 1, 0),
      Fjob_teacher = ifelse(Fjob == "teacher", 1, 0),
      Fjob_services = ifelse(Fjob == "services", 1, 0),
      Fjob_other = ifelse(Fjob == "other", 1, 0),
      reason_course = ifelse(reason == "course", 1, 0),
      reason_other = ifelse(reason == "other", 1, 0),
      reason_home = ifelse(reason == "home", 1, 0),
      reason_reputation = ifelse(reason == "reputation", 1, 0),
      guardian_mother = ifelse(guardian == "mother", 1, 0),
      guardian_father = ifelse(guardian == "father", 1, 0),
      guardian_other = ifelse(guardian == "other", 1, 0),
      schoolsup = ifelse(schoolsup == "yes", 1, 0),
      famsup = ifelse(famsup == "yes", 1, 0),
      paid = ifelse(paid == "yes", 1, 0),
      activities = ifelse(activities == "yes", 1, 0),
      nursery = ifelse(nursery == "yes", 1, 0),
      higher = ifelse(higher == "yes", 1, 0),
      internet = ifelse(internet == "yes", 1, 0),
      romantic = ifelse(romantic == "yes", 1, 0)
    ) |>
    select(-c(Mjob, Fjob, reason, guardian))
}


df_categorical_to_dummyvars <- function(dataset) {
  
  #' Return the dataset, converting specific categorical variables to dummy vars 
  #' resulting ds also exludes these original categorical vars 
  #'  
  categorical_cols <- c(
    "school", "sex", "address", "famsize", "Pstatus", "Mjob", "Fjob", "reason",
    "guardian", "schoolsup", "famsup", "paid", "activities", "nursery",
    "higher", "internet", "romantic"
  )
  datasetwithoutcat <- dummy_cols(dataset,
    select_columns = categorical_cols,
    remove_first_dummy = TRUE
  ) %>%
    select(-all_of(categorical_cols))
}
