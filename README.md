# MLOps-GHA-R

A machine learning operations project using R with GitHub Actions, following the Cookiecutter Data Science structure.

## Project Organization

```
├── LICENSE
├── README.md          <- The top-level README for developers using this project
├── data
│   ├── external       <- Data from third party sources
│   ├── interim        <- Intermediate data that has been transformed
│   ├── processed      <- The final, canonical data sets for modeling
│   └── raw            <- The original, immutable data dump
│
├── models             <- Trained and serialized models, model predictions, or model summaries
│
├── notebooks          <- R Markdown notebooks. Naming convention is a number (for ordering),
│                         the creator's initials, and a short `-` delimited description, e.g.
│                         `01-ka-initial-data-exploration.Rmd`
│
├── references         <- Data dictionaries, manuals, and all other explanatory materials
│
├── reports            <- Generated analysis as HTML, PDF, LaTeX, etc.
│   └── figures        <- Generated graphics and figures to be used in reporting
│
├── src                <- Source code for use in this project
│   ├── data           <- Scripts to download or generate data
│   │   └── make_dataset.R
│   │
│   ├── models         <- Scripts to train models and then use trained models to make predictions
│   │   ├── train_model.R
│   │   └── predict_model.R
│   │
│   └── visualization  <- Scripts to create exploratory and results oriented visualizations
│       └── visualize.R
│
└── DESCRIPTION        <- R package dependencies and project metadata
```

## Getting Started

### Quick Start

See [QUICKSTART.md](QUICKSTART.md) for detailed installation and usage instructions.

### Prerequisites

- R (>= 4.0.0)
- RStudio (recommended)
- Make (optional, for convenience commands)
- Required R packages (see [DESCRIPTION](DESCRIPTION))

### Installation

1. Clone the repository:
```bash
git clone https://github.com/korkridake/MLOps-GHA-R.git
cd MLOps-GHA-R
```

2. Install required R packages:
```bash
# Automated setup
Rscript setup.R

# Or manually in R
install.packages(c("mlflow", "tidyverse", "caret", "randomForest", "carrier"))
```

### Usage

#### Run the Complete Pipeline

```bash
# Using Make
make pipeline

# Or directly
Rscript main.R
```

#### Run Individual Steps

1. **Data Preparation**: Process the Titanic dataset
```bash
make data  # or: Rscript src/data/make_dataset.R
```

2. **Model Training**: Train a Random Forest model with MLflow tracking
```bash
make train  # or: Rscript src/models/train_model.R
```

3. **Model Prediction**: Make predictions using the trained model
```bash
make predict  # or: Rscript src/models/predict_model.R
```

4. **Visualization**: Generate plots and visualizations
```bash
make visualize  # or: Rscript src/visualization/visualize.R
```

5. **View MLflow UI**: View experiment tracking results
```bash
make mlflow  # or: mlflow ui
```

Then navigate to http://localhost:5000

## MLflow Integration

This project uses MLflow for:
- Experiment tracking
- Parameter logging
- Metric logging
- Model versioning
- Model registry

All model training runs are automatically logged to MLflow, including:
- Hyperparameters
- Evaluation metrics (accuracy, precision, recall, F1-score)
- Model artifacts
- Training/validation datasets

## Example Dataset

The project includes an example using the Titanic dataset to predict passenger survival. The dataset includes features such as:
- Passenger class
- Age
- Sex
- Number of siblings/spouses aboard
- Number of parents/children aboard
- Fare
- Port of embarkation

For more details, see the [Data Dictionary](references/data_dictionary.md).

## Documentation

- **[Quick Start Guide](QUICKSTART.md)**: Get up and running quickly
- **[MLflow Integration Guide](references/mlflow_guide.md)**: Learn how to use MLflow for experiment tracking
- **[Data Dictionary](references/data_dictionary.md)**: Understand the Titanic dataset
- **[Contributing Guide](CONTRIBUTING.md)**: Contribute to the project

## Project Features

- ✅ **Cookiecutter Data Science Structure**: Organized, standardized project layout
- ✅ **MLflow Integration**: Complete experiment tracking and model management
- ✅ **Reproducible Pipeline**: End-to-end ML pipeline with clear steps
- ✅ **Data Visualization**: Automated generation of exploratory plots
- ✅ **Model Training**: Random Forest classification with hyperparameter tracking
- ✅ **R Markdown Notebooks**: Interactive data exploration
- ✅ **GitHub Actions**: CI/CD workflow for automated training
- ✅ **Make Commands**: Convenient shortcuts for common tasks

## Available Make Commands

```bash
make setup        # Install required R packages
make data         # Prepare the Titanic dataset
make train        # Train the model with MLflow tracking
make predict      # Make predictions using trained model
make visualize    # Create visualizations
make pipeline     # Run the complete ML pipeline
make mlflow       # Start MLflow UI
make clean        # Remove generated files
```

## License

MIT License - see the [LICENSE](LICENSE) file for details