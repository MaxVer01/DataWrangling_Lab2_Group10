library(tidyverse)
library(ggplot2)

# Load utils and functions 
source("pre-processing_utils.R")
source("analysis_utils.R")
source("plotting_utils.R")

train <- readRDS("raw_data/train.rds")
test <- readRDS("raw_data/test.rds")

# split the original train set into 80% and 20%
train_splits <- train |> 
    mutate(split = sample(rep(c('train','test'),times=c(253,63))))

# Check if there is any Na 
sum(is.na(train_splits))

train.subset <- train_splits |> filter(split == "train")
test.unseen  <- train_splits |> filter(split == "test")

train.numeric <- df_as_numeric(train.subset)


# predictor list ignoring score and failures 
runFormulaSeeker <- FALSE
predictors <- colnames(train.numeric) 
predictors <- predictors[predictors != "failures" || predictors != "score"]


if (runFormulaSeeker){
  # the initial predictor is failures because has the higher correlation 
  linearReg.formula <- assemble_linear_formula(train.numeric, 
                                               predictors,
                                               max_pred_number=7, 
                                               init_formula="score~failures")
}else{
  linearReg.formula <- "score~failures+sex+Medu+schoolsup+goout+romantic+Mjob_other"
}

  
linearReg.model <- lm(formula = linearReg.formula, data = train.numeric)
coef(linearReg.model)

# Testing the model using the unseen data 
test.unseen.numeric <-  df_as_numeric(test.unseen)

mse(y_true = test.unseen$score, 
    y_pred = predict(linearReg.model, newdata =test.unseen.numeric))

