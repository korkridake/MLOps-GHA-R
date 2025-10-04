# .Rprofile for MLOps-GHA-R Project

# Set CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Set default number of digits for printing
options(digits = 4)

# Suppress startup messages
options(startup.message = FALSE)

# Project-specific settings
if (interactive()) {
  cat("\n")
  cat("==========================================\n")
  cat("  Welcome to MLOps-GHA-R\n")
  cat("==========================================\n")
  cat("\n")
  cat("Quick commands:\n")
  cat("  - Run full pipeline:  source('main.R')\n")
  cat("  - Prepare data:       source('src/data/make_dataset.R')\n")
  cat("  - Train model:        source('src/models/train_model.R')\n")
  cat("  - Make predictions:   source('src/models/predict_model.R')\n")
  cat("  - Visualize:          source('src/visualization/visualize.R')\n")
  cat("\n")
  cat("Documentation:\n")
  cat("  - Quick Start:        See QUICKSTART.md\n")
  cat("  - MLflow Guide:       See references/mlflow_guide.md\n")
  cat("  - Data Dictionary:    See references/data_dictionary.md\n")
  cat("\n")
}

# Load commonly used libraries
.First <- function() {
  if (interactive()) {
    suppressPackageStartupMessages({
      if (requireNamespace("tidyverse", quietly = TRUE)) {
        library(tidyverse)
      }
    })
  }
}

# Helper function to check if all dependencies are installed
check_dependencies <- function() {
  required_packages <- c(
    "mlflow", "tidyverse", "caret", "randomForest", 
    "ggplot2", "dplyr", "readr", "carrier"
  )
  
  missing_packages <- required_packages[!sapply(required_packages, requireNamespace, quietly = TRUE)]
  
  if (length(missing_packages) > 0) {
    cat("Missing packages:", paste(missing_packages, collapse = ", "), "\n")
    cat("Install them with: install.packages(c('", paste(missing_packages, collapse = "', '"), "'))\n", sep = "")
    return(FALSE)
  } else {
    cat("All required packages are installed!\n")
    return(TRUE)
  }
}
