# Quick Start Guide

This guide will help you get started with the MLOps-GHA-R project quickly.

## Prerequisites

Before you begin, ensure you have:

- R (version 4.0.0 or higher)
- RStudio (optional, but recommended)
- Make (optional, for using Makefile commands)
- Git

## Installation

### Step 1: Clone the Repository

```bash
git clone https://github.com/korkridake/MLOps-GHA-R.git
cd MLOps-GHA-R
```

### Step 2: Install Dependencies

You can install dependencies in two ways:

#### Option A: Using the setup script

```bash
Rscript setup.R
```

#### Option B: Manual installation

Open R or RStudio and run:

```r
install.packages(c(
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
))
```

## Running the Pipeline

### Quick Run (All Steps)

To run the entire ML pipeline at once:

```bash
# Using Make
make pipeline

# Or directly with R
Rscript main.R
```

This will:
1. Download and process the Titanic dataset
2. Train a Random Forest model with MLflow tracking
3. Make predictions
4. Generate visualizations

### Step-by-Step Execution

For more control, run each step individually:

#### Step 1: Prepare Data

```bash
# Using Make
make data

# Or directly with R
Rscript src/data/make_dataset.R
```

This downloads the Titanic dataset and processes it.

#### Step 2: Train Model

```bash
# Using Make
make train

# Or directly with R
Rscript src/models/train_model.R
```

This trains a Random Forest model and logs everything to MLflow.

#### Step 3: Make Predictions

```bash
# Using Make
make predict

# Or directly with R
Rscript src/models/predict_model.R
```

This uses the trained model to make predictions.

#### Step 4: Create Visualizations

```bash
# Using Make
make visualize

# Or directly with R
Rscript src/visualization/visualize.R
```

This generates plots for data exploration and model results.

## Viewing Results

### MLflow UI

To view experiment tracking results:

```bash
# Using Make
make mlflow

# Or directly
mlflow ui
```

Then open your browser and navigate to: http://localhost:5000

The MLflow UI shows:
- All experiment runs
- Parameters used in each run
- Metrics (accuracy, precision, recall, F1)
- Artifacts (models, plots, confusion matrices)

### Generated Files

After running the pipeline, you'll find:

- **Data**: `data/processed/titanic_processed.csv`
- **Model**: `models/titanic_rf_model.rds`
- **Predictions**: `models/predictions.csv`
- **Visualizations**: `reports/figures/*.png`
- **MLflow Data**: `mlruns/` directory

### Visualizations

Check the `reports/figures/` directory for:
- `survival_by_gender.png`: Survival rates by gender
- `survival_by_class.png`: Survival rates by passenger class
- `age_distribution.png`: Age distribution by survival
- `fare_by_class_survival.png`: Fare distribution
- `feature_importance.png`: Feature importance from the model

## Exploring the Data

### R Markdown Notebook

Open and knit the exploration notebook:

1. Open RStudio
2. Navigate to `notebooks/01-initial-data-exploration.Rmd`
3. Click "Knit" to generate an HTML report

This provides detailed data exploration with visualizations.

### Interactive R Session

```r
# Load the processed data
library(tidyverse)
titanic <- read_csv("data/processed/titanic_processed.csv")

# View summary
summary(titanic)

# Explore survival rates
table(titanic$Survived, titanic$Sex)
table(titanic$Survived, titanic$Pclass)

# Load and inspect the model
model <- readRDS("models/titanic_rf_model.rds")
print(model)
importance(model)
```

## Customizing Model Training

You can customize model training by editing parameters:

### In the Script

Edit `src/models/train_model.R` or call the function with different parameters:

```r
source("src/models/train_model.R")

# Train with different hyperparameters
model <- train_titanic_model(
  n_trees = 200,        # Number of trees
  mtry = 4,             # Features per split
  max_depth = 10,       # Maximum tree depth
  test_size = 0.3,      # Test set proportion
  random_seed = 123     # Random seed
)
```

All parameters and metrics will be logged to MLflow for comparison.

## Making Predictions on New Data

To make predictions for new passengers:

```r
source("src/models/predict_model.R")

# Create new passenger data
new_passengers <- data.frame(
  Pclass = c(1, 3),
  Sex = c("female", "male"),
  Age = c(30, 25),
  SibSp = c(0, 1),
  Parch = c(0, 0),
  Fare = c(100, 10),
  Embarked = c("S", "S")
)

# Make predictions
predictions <- predict_new_data(new_passengers)
print(predictions)
```

## Cleaning Up

To remove all generated files:

```bash
# Using Make
make clean

# Or manually
rm -rf data/raw/*.csv data/processed/*.csv
rm -rf models/*.rds models/*.txt models/*.csv
rm -rf reports/figures/*.png
rm -rf mlruns/
```

## Next Steps

- **Experiment**: Try different models (e.g., logistic regression, SVM)
- **Feature Engineering**: Create new features from existing ones
- **Hyperparameter Tuning**: Use grid search or random search
- **Model Deployment**: Set up model serving with MLflow
- **CI/CD**: Configure GitHub Actions for automatic training

## Troubleshooting

### Issue: Package installation fails

Try installing packages one at a time:
```r
install.packages("mlflow")
install.packages("tidyverse")
# etc.
```

### Issue: Dataset download fails

Manually download the Titanic dataset from:
https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv

And place it in `data/raw/titanic.csv`

### Issue: MLflow not starting

Ensure Python is installed (MLflow has a Python backend):
```bash
pip install mlflow
```

### Issue: Model training fails

Check that:
1. Data has been processed: `data/processed/titanic_processed.csv` exists
2. All required packages are installed
3. You're running from the project root directory

## Getting Help

- Check the [README](README.md) for project overview
- Read the [Data Dictionary](references/data_dictionary.md) for dataset details
- Review the [MLflow Guide](references/mlflow_guide.md) for experiment tracking
- Open an issue on GitHub for bugs or questions

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
