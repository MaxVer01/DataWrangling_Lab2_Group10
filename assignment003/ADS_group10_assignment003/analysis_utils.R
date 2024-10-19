# Functions related to the analysis process

mse <- function(y_true, y_pred) {
  mean((y_true - y_pred)^2)
}


cv_lm <- function(formula, dataset, k) {
  #' cross validation for linear regression,
  #' original implementation here:
  #' https://infomdwr.nl/labs/week_5/2_supervised_1/supervised_1_answers_34b1c2a.html

  stopifnot(is_formula(formula))
  stopifnot(is.data.frame(dataset))
  stopifnot(is.integer(as.integer(k)))

  n_samples <- nrow(dataset)
  select_vec <- rep(1:k, length.out = n_samples)
  data_split <- dataset %>% mutate(folds = sample(select_vec))

  mses <- rep(0, k)
  for (i in 1:k) {
    data_train <- data_split %>% filter(folds != i)
    data_valid <- data_split %>% filter(folds == i)
    model_i <- lm(formula = formula, data = data_train)

    y_column_name <- as.character(formula)[2]
    mses[i] <- mse(
      y_true = data_valid[[y_column_name]],
      y_pred = predict(model_i, newdata = data_valid)
    )
  }
  mean(mses)
}



assemble_linear_formula <- function(train.numeric, predictors, max_pred_number = 5, init_formula) {
  #' this method implements the attribute selection described in the book as Mixed selection. 
  #' with some variation using mse as measure 
  #' as a result returns the predictor that min the MSE error using cross-validation
  #'

  c_formula <- init_formula
  min_mse <- cv_lm(formula = as.formula(c_formula), dataset = train.numeric, k = 9)
  predictorsNumber <- 7


  for (i in 1:max_pred_number) {
    min_pred <- ""
    min_formula <- NULL
    for (predictor in predictors) {
      current_formula <- paste(c_formula, predictor, sep = "+")
      current_mse <- cv_lm(formula = as.formula(current_formula), dataset = train.numeric, k = 9)
      print(sprintf("%s, MSE=%.2f", current_formula, current_mse))

      if (current_mse < min_mse) {
        min_formula <- current_formula
        min_pred <- predictor
        min_mse <- current_mse
      }
    }
    # exclude the best current predictor from the predictors list
    predictors <- predictors[predictors != min_pred]
    if (!is.null(min_formula)) {
      c_formula <- min_formula
    }
  }

  print(paste("the final formula is: ", c_formula))
  c_formula
}
