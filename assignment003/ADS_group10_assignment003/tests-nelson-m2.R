library(tidyverse)
library(tidyr)

library(tidymodels) # neeed to be installed 
library(rpart.plot) # need to be installed 
library(tree)
library(randomForest)


# source https://www.datacamp.com/tutorial/decision-trees-R 


train <- readRDS("raw_data/train.rds")
test <- readRDS("raw_data/test.rds") 


train_splits <- train |>
  mutate(split = sample(rep(c('train','test'),times=c( round((nrow(train)*0.80))  ,
                                                       nrow(train) - round((nrow(train)*0.80))))))

default_train <- train_splits |> filter(split == 'train') |> select(-split)
default_test <- train_splits |> filter(split=='test') |> select(-split)



tree_config <- decision_tree(tree_depth = 5) %>% set_engine("rpart") %>% set_mode("regression") 
tree_fit <- tree_config %>% fit(score~., data=train)


predictions <- tree_fit %>% predict(default_test) %>% pull(.pred)


mse <- function(y_true, y_pred) {
  mean((y_true- y_pred)^2 )
}


mse(y_true = default_test$score, y_pred =  predictions)

rpart.plot(tree_fit$fit)
print(tree_fit)

bag.train <- randomForest(score~., data=default_train, mtry=20,   importance=TRUE)
yRpred <- predict(bag.train, newdata = default_test)
mse( y_true=default_test$score, y_pred =  yRpred)
