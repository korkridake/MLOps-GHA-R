#!/usr/bin/env Rscript

# Main Pipeline Script
# Runs the complete ML pipeline: data preparation, training, prediction, and visualization

cat("========================================\n")
cat("MLOps-GHA-R Pipeline\n")
cat("========================================\n\n")

# Set working directory to project root if running from elsewhere
if (!grepl("MLOps-GHA-R$", getwd())) {
  stop("Please run this script from the project root directory")
}

# Step 1: Data Preparation
cat("Step 1: Preparing data...\n")
cat("----------------------------------------\n")
source("src/data/make_dataset.R")
prepare_titanic_data()
cat("\n")

# Step 2: Model Training with MLflow
cat("Step 2: Training model with MLflow tracking...\n")
cat("----------------------------------------\n")
source("src/models/train_model.R")
model <- train_titanic_model(
  n_trees = 100,
  mtry = 3,
  test_size = 0.2,
  random_seed = 42
)
cat("\n")

# Step 3: Making Predictions
cat("Step 3: Making predictions...\n")
cat("----------------------------------------\n")
source("src/models/predict_model.R")
predictions <- predict_survival()
cat("\n")

# Step 4: Creating Visualizations
cat("Step 4: Creating visualizations...\n")
cat("----------------------------------------\n")
source("src/visualization/visualize.R")
visualize_titanic_data()
visualize_model_performance()
cat("\n")

# Summary
cat("========================================\n")
cat("Pipeline completed successfully!\n")
cat("========================================\n\n")
cat("Outputs:\n")
cat("  - Processed data: data/processed/titanic_processed.csv\n")
cat("  - Trained model: models/titanic_rf_model.rds\n")
cat("  - Predictions: models/predictions.csv\n")
cat("  - Visualizations: reports/figures/*.png\n")
cat("  - MLflow tracking: mlruns/\n\n")
cat("To view MLflow experiments, run: mlflow ui\n")
cat("Then navigate to: http://localhost:5000\n")
