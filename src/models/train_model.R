# Train Model
# Script to train a Random Forest model on the Titanic dataset with MLflow tracking

library(tidyverse)
library(mlflow)
library(caret)
library(randomForest)

# Function to train model with MLflow tracking
train_titanic_model <- function(
  n_trees = 100,
  mtry = 3,
  max_depth = NULL,
  test_size = 0.2,
  random_seed = 42
) {
  
  # Start MLflow run
  mlflow_start_run()
  
  tryCatch({
    message("Starting model training with MLflow tracking...")
    
    # Log parameters
    mlflow_log_param("n_trees", n_trees)
    mlflow_log_param("mtry", mtry)
    mlflow_log_param("max_depth", ifelse(is.null(max_depth), "NULL", max_depth))
    mlflow_log_param("test_size", test_size)
    mlflow_log_param("random_seed", random_seed)
    
    # Load processed data
    data_path <- "data/processed/titanic_processed.csv"
    if (!file.exists(data_path)) {
      stop("Processed data not found. Please run src/data/make_dataset.R first.")
    }
    
    titanic_data <- read_csv(data_path, show_col_types = FALSE) %>%
      mutate(
        Survived = factor(Survived, levels = c("No", "Yes")),
        Pclass = factor(Pclass),
        Sex = factor(Sex),
        Embarked = factor(Embarked)
      )
    
    message(sprintf("Loaded %d rows of data", nrow(titanic_data)))
    
    # Split data into training and testing sets
    set.seed(random_seed)
    train_index <- createDataPartition(titanic_data$Survived, p = 1 - test_size, list = FALSE)
    train_data <- titanic_data[train_index, ]
    test_data <- titanic_data[-train_index, ]
    
    message(sprintf("Training set: %d rows, Test set: %d rows", 
                    nrow(train_data), nrow(test_data)))
    
    mlflow_log_param("train_size", nrow(train_data))
    mlflow_log_param("test_size_actual", nrow(test_data))
    
    # Train Random Forest model
    message("Training Random Forest model...")
    model <- randomForest(
      Survived ~ .,
      data = train_data,
      ntree = n_trees,
      mtry = mtry,
      maxnodes = max_depth,
      importance = TRUE
    )
    
    # Make predictions on test set
    predictions <- predict(model, test_data)
    
    # Calculate metrics
    conf_matrix <- confusionMatrix(predictions, test_data$Survived)
    accuracy <- conf_matrix$overall["Accuracy"]
    precision <- conf_matrix$byClass["Precision"]
    recall <- conf_matrix$byClass["Recall"]
    f1_score <- conf_matrix$byClass["F1"]
    
    # Log metrics
    mlflow_log_metric("accuracy", accuracy)
    mlflow_log_metric("precision", precision)
    mlflow_log_metric("recall", recall)
    mlflow_log_metric("f1_score", f1_score)
    
    message(sprintf("Model Accuracy: %.4f", accuracy))
    message(sprintf("Model Precision: %.4f", precision))
    message(sprintf("Model Recall: %.4f", recall))
    message(sprintf("Model F1 Score: %.4f", f1_score))
    
    # Save model
    dir.create("models", showWarnings = FALSE, recursive = TRUE)
    model_path <- "models/titanic_rf_model.rds"
    saveRDS(model, model_path)
    message(sprintf("Model saved to %s", model_path))
    
    # Log model artifact
    mlflow_log_artifact(model_path)
    
    # Log confusion matrix as text artifact
    conf_matrix_path <- "models/confusion_matrix.txt"
    sink(conf_matrix_path)
    print(conf_matrix)
    sink()
    mlflow_log_artifact(conf_matrix_path)
    
    # Log feature importance
    importance_df <- as.data.frame(importance(model))
    importance_df$Feature <- rownames(importance_df)
    importance_path <- "models/feature_importance.csv"
    write_csv(importance_df, importance_path)
    mlflow_log_artifact(importance_path)
    
    message("\nFeature Importance:")
    print(importance_df %>% arrange(desc(MeanDecreaseGini)))
    
    # Log the caret model using mlflow
    mlflow_log_model(
      model = crate(function(new_data) {
        predict(!!model, new_data)
      }, model = model),
      artifact_path = "model"
    )
    
    message("\nModel training complete!")
    
  }, finally = {
    # End MLflow run
    mlflow_end_run()
  })
  
  return(model)
}

# Run training if script is executed directly
if (!interactive()) {
  model <- train_titanic_model()
}
