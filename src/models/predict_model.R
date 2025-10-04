# Predict Model
# Script to make predictions using the trained model

library(tidyverse)
library(randomForest)

# Function to load model and make predictions
predict_survival <- function(model_path = "models/titanic_rf_model.rds",
                            data_path = "data/processed/titanic_processed.csv") {
  
  message("Loading trained model...")
  
  # Check if model exists
  if (!file.exists(model_path)) {
    stop("Model not found. Please train a model first using src/models/train_model.R")
  }
  
  # Load the trained model
  model <- readRDS(model_path)
  message(sprintf("Model loaded from %s", model_path))
  
  # Load data for predictions
  if (!file.exists(data_path)) {
    stop("Data not found. Please run src/data/make_dataset.R first.")
  }
  
  data <- read_csv(data_path, show_col_types = FALSE) %>%
    mutate(
      Survived = factor(Survived, levels = c("No", "Yes")),
      Pclass = factor(Pclass),
      Sex = factor(Sex),
      Embarked = factor(Embarked)
    )
  
  message(sprintf("Loaded %d rows for prediction", nrow(data)))
  
  # Make predictions
  predictions <- predict(model, data, type = "class")
  probabilities <- predict(model, data, type = "prob")
  
  # Combine results
  results <- data %>%
    mutate(
      Predicted = predictions,
      Prob_No = probabilities[, "No"],
      Prob_Yes = probabilities[, "Yes"]
    )
  
  # Save predictions
  dir.create("models", showWarnings = FALSE, recursive = TRUE)
  output_path <- "models/predictions.csv"
  write_csv(results, output_path)
  message(sprintf("Predictions saved to %s", output_path))
  
  # Print summary
  message("\nPrediction Summary:")
  print(table(Actual = results$Survived, Predicted = results$Predicted))
  
  accuracy <- mean(results$Survived == results$Predicted)
  message(sprintf("\nPrediction Accuracy: %.4f", accuracy))
  
  return(results)
}

# Function to predict for new data
predict_new_data <- function(new_data, model_path = "models/titanic_rf_model.rds") {
  
  message("Making predictions for new data...")
  
  # Load the trained model
  if (!file.exists(model_path)) {
    stop("Model not found. Please train a model first using src/models/train_model.R")
  }
  
  model <- readRDS(model_path)
  
  # Ensure data has correct structure
  new_data <- new_data %>%
    mutate(
      Pclass = factor(Pclass),
      Sex = factor(Sex),
      Embarked = factor(Embarked)
    )
  
  # Make predictions
  predictions <- predict(model, new_data, type = "class")
  probabilities <- predict(model, new_data, type = "prob")
  
  # Combine results
  results <- new_data %>%
    mutate(
      Predicted_Survival = predictions,
      Probability_No = probabilities[, "No"],
      Probability_Yes = probabilities[, "Yes"]
    )
  
  return(results)
}

# Example usage for new passengers
example_prediction <- function() {
  message("Running example prediction...")
  
  # Create example passengers
  new_passengers <- tibble(
    Pclass = factor(c(1, 3, 2)),
    Sex = factor(c("female", "male", "female")),
    Age = c(29, 22, 35),
    SibSp = c(0, 1, 1),
    Parch = c(0, 0, 2),
    Fare = c(100, 7.25, 30),
    Embarked = factor(c("S", "S", "C"))
  )
  
  predictions <- predict_new_data(new_passengers)
  
  message("\nExample Predictions:")
  print(predictions)
  
  return(predictions)
}

# Run predictions if script is executed directly
if (!interactive()) {
  results <- predict_survival()
  example_prediction()
}
