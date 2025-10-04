#!/usr/bin/env Rscript

# Setup Script
# Installs required R packages for the MLOps-GHA-R project

cat("========================================\n")
cat("MLOps-GHA-R Setup\n")
cat("========================================\n\n")

cat("Installing required R packages...\n\n")

# List of required packages
required_packages <- c(
  "mlflow",
  "tidyverse",
  "caret",
  "randomForest",
  "ggplot2",
  "dplyr",
  "readr",
  "carrier",
  "knitr",
  "rmarkdown"
)

# Function to install packages if not already installed
install_if_missing <- function(package) {
  if (!require(package, character.only = TRUE, quietly = TRUE)) {
    cat(sprintf("Installing %s...\n", package))
    install.packages(package, repos = "https://cloud.r-project.org/")
  } else {
    cat(sprintf("%s is already installed.\n", package))
  }
}

# Install packages
for (pkg in required_packages) {
  install_if_missing(pkg)
}

cat("\n========================================\n")
cat("Setup completed!\n")
cat("========================================\n\n")

cat("Next steps:\n")
cat("1. Run the main pipeline: Rscript main.R\n")
cat("2. Or run individual scripts:\n")
cat("   - Data preparation: Rscript src/data/make_dataset.R\n")
cat("   - Model training: Rscript src/models/train_model.R\n")
cat("   - Predictions: Rscript src/models/predict_model.R\n")
cat("   - Visualizations: Rscript src/visualization/visualize.R\n")
cat("3. View MLflow experiments: mlflow ui\n")
