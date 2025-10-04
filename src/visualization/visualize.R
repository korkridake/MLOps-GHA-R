# Visualize
# Script to create visualizations for data exploration and model results

library(tidyverse)
library(ggplot2)
library(randomForest)

# Function to create exploratory data visualizations
visualize_titanic_data <- function(data_path = "data/processed/titanic_processed.csv") {
  
  message("Creating data visualizations...")
  
  # Load data
  if (!file.exists(data_path)) {
    stop("Data not found. Please run src/data/make_dataset.R first.")
  }
  
  titanic_data <- read_csv(data_path, show_col_types = FALSE) %>%
    mutate(
      Survived = factor(Survived, levels = c("No", "Yes")),
      Pclass = factor(Pclass),
      Sex = factor(Sex),
      Embarked = factor(Embarked)
    )
  
  # Create output directory
  dir.create("reports/figures", showWarnings = FALSE, recursive = TRUE)
  
  # 1. Survival rate by gender
  p1 <- ggplot(titanic_data, aes(x = Sex, fill = Survived)) +
    geom_bar(position = "fill") +
    scale_fill_manual(values = c("No" = "#e74c3c", "Yes" = "#2ecc71")) +
    labs(title = "Survival Rate by Gender",
         y = "Proportion",
         x = "Gender") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave("reports/figures/survival_by_gender.png", p1, width = 8, height = 6)
  message("Created: reports/figures/survival_by_gender.png")
  
  # 2. Survival rate by passenger class
  p2 <- ggplot(titanic_data, aes(x = Pclass, fill = Survived)) +
    geom_bar(position = "fill") +
    scale_fill_manual(values = c("No" = "#e74c3c", "Yes" = "#2ecc71")) +
    labs(title = "Survival Rate by Passenger Class",
         y = "Proportion",
         x = "Passenger Class") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave("reports/figures/survival_by_class.png", p2, width = 8, height = 6)
  message("Created: reports/figures/survival_by_class.png")
  
  # 3. Age distribution by survival
  p3 <- ggplot(titanic_data, aes(x = Age, fill = Survived)) +
    geom_histogram(bins = 30, alpha = 0.7, position = "identity") +
    scale_fill_manual(values = c("No" = "#e74c3c", "Yes" = "#2ecc71")) +
    labs(title = "Age Distribution by Survival",
         x = "Age",
         y = "Count") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave("reports/figures/age_distribution.png", p3, width = 8, height = 6)
  message("Created: reports/figures/age_distribution.png")
  
  # 4. Fare distribution by survival and class
  p4 <- ggplot(titanic_data, aes(x = Pclass, y = Fare, fill = Survived)) +
    geom_boxplot() +
    scale_fill_manual(values = c("No" = "#e74c3c", "Yes" = "#2ecc71")) +
    labs(title = "Fare Distribution by Class and Survival",
         x = "Passenger Class",
         y = "Fare") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave("reports/figures/fare_by_class_survival.png", p4, width = 8, height = 6)
  message("Created: reports/figures/fare_by_class_survival.png")
  
  message("\nAll visualizations created successfully!")
}

# Function to visualize model performance
visualize_model_performance <- function(model_path = "models/titanic_rf_model.rds",
                                       data_path = "data/processed/titanic_processed.csv") {
  
  message("Creating model performance visualizations...")
  
  # Load model
  if (!file.exists(model_path)) {
    stop("Model not found. Please train a model first using src/models/train_model.R")
  }
  
  model <- readRDS(model_path)
  
  # Load data
  if (!file.exists(data_path)) {
    stop("Data not found. Please run src/data/make_dataset.R first.")
  }
  
  titanic_data <- read_csv(data_path, show_col_types = FALSE) %>%
    mutate(
      Survived = factor(Survived, levels = c("No", "Yes")),
      Pclass = factor(Pclass),
      Sex = factor(Sex),
      Embarked = factor(Embarked)
    )
  
  # Create output directory
  dir.create("reports/figures", showWarnings = FALSE, recursive = TRUE)
  
  # Feature importance plot
  importance_df <- as.data.frame(importance(model))
  importance_df$Feature <- rownames(importance_df)
  importance_df <- importance_df %>% arrange(desc(MeanDecreaseGini))
  
  p5 <- ggplot(importance_df, aes(x = reorder(Feature, MeanDecreaseGini), 
                                   y = MeanDecreaseGini)) +
    geom_col(fill = "#3498db") +
    coord_flip() +
    labs(title = "Feature Importance (Mean Decrease in Gini)",
         x = "Feature",
         y = "Mean Decrease Gini") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  
  ggsave("reports/figures/feature_importance.png", p5, width = 8, height = 6)
  message("Created: reports/figures/feature_importance.png")
  
  message("\nModel performance visualizations created successfully!")
}

# Run visualizations if script is executed directly
if (!interactive()) {
  visualize_titanic_data()
  visualize_model_performance()
}
