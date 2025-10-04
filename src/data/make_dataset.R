# Make Dataset
# Script to download and process the Titanic dataset

library(tidyverse)

# Function to download and prepare Titanic dataset
prepare_titanic_data <- function() {
  message("Preparing Titanic dataset...")
  
  # Create directories if they don't exist
  dir.create("data/raw", showWarnings = FALSE, recursive = TRUE)
  dir.create("data/processed", showWarnings = FALSE, recursive = TRUE)
  
  # Download Titanic dataset if not already present
  train_url <- "https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv"
  raw_data_path <- "data/raw/titanic.csv"
  
  if (!file.exists(raw_data_path)) {
    message("Downloading Titanic dataset...")
    download.file(train_url, raw_data_path, method = "auto")
    message("Download complete!")
  } else {
    message("Titanic dataset already exists.")
  }
  
  # Load the raw data
  titanic_raw <- read_csv(raw_data_path, show_col_types = FALSE)
  message(sprintf("Loaded %d rows and %d columns", nrow(titanic_raw), ncol(titanic_raw)))
  
  # Process the data
  titanic_processed <- titanic_raw %>%
    # Select relevant features
    select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare, Embarked) %>%
    # Handle missing values
    mutate(
      Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age),
      Fare = ifelse(is.na(Fare), median(Fare, na.rm = TRUE), Fare),
      Embarked = ifelse(is.na(Embarked) | Embarked == "", "S", Embarked)
    ) %>%
    # Convert categorical variables to factors
    mutate(
      Survived = factor(Survived, levels = c(0, 1), labels = c("No", "Yes")),
      Pclass = factor(Pclass),
      Sex = factor(Sex),
      Embarked = factor(Embarked)
    ) %>%
    # Remove any remaining rows with NA
    drop_na()
  
  # Save processed data
  processed_data_path <- "data/processed/titanic_processed.csv"
  write_csv(titanic_processed, processed_data_path)
  message(sprintf("Processed data saved to %s", processed_data_path))
  message(sprintf("Final dataset: %d rows and %d columns", 
                  nrow(titanic_processed), ncol(titanic_processed)))
  
  # Print summary statistics
  message("\nDataset Summary:")
  print(summary(titanic_processed))
  
  return(titanic_processed)
}

# Run the data preparation
if (!interactive()) {
  prepare_titanic_data()
}
