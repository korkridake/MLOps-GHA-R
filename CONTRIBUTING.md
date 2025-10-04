# Contributing to MLOps-GHA-R

Thank you for your interest in contributing to MLOps-GHA-R! This document provides guidelines for contributing to the project.

## Code of Conduct

This project adheres to a code of conduct. By participating, you are expected to uphold this code. Please be respectful and considerate in all interactions.

## How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:

1. A clear, descriptive title
2. Steps to reproduce the issue
3. Expected behavior
4. Actual behavior
5. R version and package versions
6. Any relevant error messages or logs

### Suggesting Enhancements

For feature requests or enhancements:

1. Check if the feature has already been suggested
2. Open an issue with a clear description of the enhancement
3. Explain why this enhancement would be useful
4. Provide examples if possible

### Pull Requests

1. **Fork the repository**
   ```bash
   git clone https://github.com/YOUR-USERNAME/MLOps-GHA-R.git
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes**
   - Follow the existing code style
   - Add comments where necessary
   - Update documentation if needed

4. **Test your changes**
   - Run the full pipeline to ensure nothing breaks
   - Test with different parameter values
   - Verify MLflow logging works correctly

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: description of changes"
   ```

6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```

7. **Open a Pull Request**
   - Provide a clear description of the changes
   - Reference any related issues
   - Explain how you tested the changes

## Development Guidelines

### Code Style

- Use meaningful variable names
- Follow R style guides (e.g., Tidyverse style guide)
- Use `<-` for assignment
- Add comments for complex logic
- Keep functions focused and modular

### Documentation

- Update README.md if adding new features
- Update relevant guides in the `references/` directory
- Add comments to explain complex code
- Update DESCRIPTION file if adding new dependencies

### Testing

Before submitting a PR:

```bash
# Run the full pipeline
Rscript main.R

# Check individual components
Rscript src/data/make_dataset.R
Rscript src/models/train_model.R
Rscript src/models/predict_model.R
Rscript src/visualization/visualize.R
```

### Project Structure

When adding new files, follow the Cookiecutter Data Science structure:

```
├── data/              # Data files (not committed)
├── models/            # Trained models (not committed)
├── notebooks/         # R Markdown notebooks
├── references/        # Documentation and guides
├── reports/           # Generated reports and figures
└── src/               # Source code
    ├── data/          # Data processing scripts
    ├── models/        # Model training and prediction
    └── visualization/ # Visualization scripts
```

### MLflow Integration

When adding or modifying model training:

1. Always use MLflow tracking
2. Log all hyperparameters
3. Log all relevant metrics
4. Log model artifacts
5. Follow the pattern in `src/models/train_model.R`

Example:
```r
mlflow_start_run()
tryCatch({
  mlflow_log_param("param_name", param_value)
  # ... training code ...
  mlflow_log_metric("metric_name", metric_value)
  mlflow_log_artifact("path/to/artifact")
}, finally = {
  mlflow_end_run()
})
```

## Areas for Contribution

### High Priority

- Additional model algorithms (logistic regression, XGBoost, etc.)
- Hyperparameter tuning functionality
- Model ensemble methods
- Automated feature engineering
- Model performance visualization improvements

### Medium Priority

- Additional datasets beyond Titanic
- Cross-validation implementation
- Model interpretation tools (SHAP, LIME)
- Docker containerization
- Model deployment examples

### Low Priority

- Additional data visualization options
- Performance optimizations
- Documentation improvements
- Example notebooks

## Questions?

If you have questions about contributing:

1. Check existing issues and pull requests
2. Open a new issue with the "question" label
3. Reach out to the maintainers

## Recognition

Contributors will be acknowledged in the project README.

## License

By contributing to this project, you agree that your contributions will be licensed under the MIT License.

Thank you for contributing to MLOps-GHA-R!
