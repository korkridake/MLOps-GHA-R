# MLflow Integration Guide

This document explains how MLflow is integrated into the MLOps-GHA-R project for experiment tracking and model management.

## Overview

MLflow is an open-source platform for managing the ML lifecycle, including experimentation, reproducibility, and deployment. This project uses the MLflow R API to track all machine learning experiments.

## MLflow Components Used

### 1. Tracking

The project uses MLflow Tracking to record and query experiments:

- **Parameters**: Model hyperparameters (e.g., n_trees, mtry, max_depth)
- **Metrics**: Model performance metrics (e.g., accuracy, precision, recall, F1-score)
- **Artifacts**: Output files (models, confusion matrices, feature importance)
- **Models**: Trained model objects

### 2. Projects

The repository follows MLflow Projects structure with:
- Reproducible runs
- Parameter definitions
- Dependency management via DESCRIPTION file

### 3. Models

Models are logged using MLflow's model format for:
- Model versioning
- Model registry
- Easy deployment

## Using MLflow in R Scripts

### Basic Workflow

```r
library(mlflow)

# 1. Start a run
mlflow_start_run()

# 2. Log parameters
mlflow_log_param("parameter_name", parameter_value)

# 3. Log metrics
mlflow_log_metric("metric_name", metric_value)

# 4. Log artifacts
mlflow_log_artifact("path/to/file")

# 5. Log model
mlflow_log_model(model, artifact_path = "model")

# 6. End the run
mlflow_end_run()
```

### Example from train_model.R

```r
train_titanic_model <- function(n_trees = 100, mtry = 3, ...) {
  # Start MLflow run
  mlflow_start_run()
  
  tryCatch({
    # Log hyperparameters
    mlflow_log_param("n_trees", n_trees)
    mlflow_log_param("mtry", mtry)
    
    # Train model
    model <- randomForest(Survived ~ ., data = train_data, 
                         ntree = n_trees, mtry = mtry)
    
    # Make predictions and calculate metrics
    predictions <- predict(model, test_data)
    accuracy <- mean(predictions == test_data$Survived)
    
    # Log metrics
    mlflow_log_metric("accuracy", accuracy)
    
    # Save and log model
    saveRDS(model, "models/model.rds")
    mlflow_log_artifact("models/model.rds")
    mlflow_log_model(model, artifact_path = "model")
    
  }, finally = {
    # Always end the run
    mlflow_end_run()
  })
}
```

## MLflow UI

### Starting the UI

```bash
mlflow ui
```

Then navigate to http://localhost:5000 in your browser.

### Using the UI

The MLflow UI provides:

1. **Experiment List**: View all experiments
2. **Run Comparison**: Compare multiple runs side-by-side
3. **Metric Visualization**: Plot metrics over time or across runs
4. **Artifact Viewer**: Browse and download logged artifacts
5. **Model Registry**: Manage model versions and stages

## Directory Structure

```
mlruns/
├── 0/                    # Default experiment
│   ├── meta.yaml
│   └── <run_id>/         # Individual run directory
│       ├── meta.yaml     # Run metadata
│       ├── metrics/      # Logged metrics
│       ├── params/       # Logged parameters
│       ├── tags/         # Run tags
│       └── artifacts/    # Logged artifacts
└── .trash/               # Deleted runs
```

## Best Practices

### 1. Naming Runs

```r
mlflow_start_run(run_name = "titanic-rf-v1")
```

### 2. Experiment Organization

```r
mlflow_set_experiment("titanic-survival-prediction")
```

### 3. Nested Runs

For complex workflows with multiple models:

```r
mlflow_start_run(run_name = "parent-run")
  
  mlflow_start_run(run_name = "model-1", nested = TRUE)
  # ... train model 1
  mlflow_end_run()
  
  mlflow_start_run(run_name = "model-2", nested = TRUE)
  # ... train model 2
  mlflow_end_run()

mlflow_end_run()
```

### 4. Tagging Runs

```r
mlflow_set_tag("model_type", "random_forest")
mlflow_set_tag("dataset", "titanic")
mlflow_set_tag("version", "1.0")
```

### 5. Searching Runs

```r
# In R
runs <- mlflow_search_runs(
  filter = "metrics.accuracy > 0.8",
  order_by = "metrics.accuracy DESC"
)
```

## Remote Tracking Server

### Configuration

To use a remote MLflow tracking server:

```r
# Set tracking URI
mlflow_set_tracking_uri("http://remote-server:5000")

# Or use environment variable
Sys.setenv(MLFLOW_TRACKING_URI = "http://remote-server:5000")
```

### With Authentication

```r
Sys.setenv(MLFLOW_TRACKING_USERNAME = "username")
Sys.setenv(MLFLOW_TRACKING_PASSWORD = "password")
```

## Model Registry

### Registering a Model

```r
# After logging a model
mlflow_register_model(
  model_uri = "runs:/<run_id>/model",
  name = "titanic-survival-model"
)
```

### Model Stages

- **None**: Default stage for newly registered models
- **Staging**: For models being tested
- **Production**: For models deployed to production
- **Archived**: For deprecated models

### Transitioning Models

```r
mlflow_transition_model_version_stage(
  name = "titanic-survival-model",
  version = 1,
  stage = "Production"
)
```

## Integration with GitHub Actions

The `.github/workflows/mlops-pipeline.yml` file demonstrates how to:

1. Run experiments automatically on push
2. Log results to MLflow
3. Upload artifacts to GitHub
4. (Optional) Push results to remote MLflow server

### Environment Variables

Set these secrets in GitHub repository settings:

- `MLFLOW_TRACKING_URI`: URL of remote MLflow server
- `MLFLOW_TRACKING_USERNAME`: Username for authentication
- `MLFLOW_TRACKING_PASSWORD`: Password for authentication

## Troubleshooting

### Issue: MLflow not found

```r
install.packages("mlflow")
```

### Issue: Connection error to tracking server

Check the tracking URI:
```r
mlflow_get_tracking_uri()
```

### Issue: Artifacts not logged

Ensure the file path exists before logging:
```r
if (file.exists("model.rds")) {
  mlflow_log_artifact("model.rds")
}
```

## Additional Resources

- [MLflow Documentation](https://mlflow.org/docs/latest/index.html)
- [MLflow R API Documentation](https://mlflow.org/docs/latest/R-api.html)
- [MLflow Tracking Guide](https://mlflow.org/docs/latest/tracking.html)
- [MLflow Model Registry Guide](https://mlflow.org/docs/latest/model-registry.html)
