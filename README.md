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
└── renv.lock          <- The requirements file for reproducing the R environment
```

## Getting Started

### Prerequisites

- R (>= 4.0.0)
- RStudio (recommended)
- Required R packages:
  - mlflow
  - tidyverse
  - caret
  - randomForest

### Installation

1. Clone the repository:
```bash
git clone https://github.com/korkridake/MLOps-GHA-R.git
cd MLOps-GHA-R
```

2. Install required R packages:
```R
install.packages(c("mlflow", "tidyverse", "caret", "randomForest"))
```

### Usage

1. **Data Preparation**: Process the Titanic dataset
```R
source("src/data/make_dataset.R")
```

2. **Model Training**: Train a Random Forest model with MLflow tracking
```R
source("src/models/train_model.R")
```

3. **Model Prediction**: Make predictions using the trained model
```R
source("src/models/predict_model.R")
```

4. **View MLflow UI**: View experiment tracking results
```bash
mlflow ui
```

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

## License

MIT License - see the [LICENSE](LICENSE) file for details