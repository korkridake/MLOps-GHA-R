.PHONY: help setup data train predict visualize clean pipeline mlflow

help:
	@echo "Available commands:"
	@echo "  make setup        - Install required R packages"
	@echo "  make data         - Prepare the Titanic dataset"
	@echo "  make train        - Train the model with MLflow tracking"
	@echo "  make predict      - Make predictions using trained model"
	@echo "  make visualize    - Create visualizations"
	@echo "  make pipeline     - Run the complete ML pipeline"
	@echo "  make mlflow       - Start MLflow UI"
	@echo "  make clean        - Remove generated files"

setup:
	Rscript setup.R

data:
	Rscript src/data/make_dataset.R

train:
	Rscript src/models/train_model.R

predict:
	Rscript src/models/predict_model.R

visualize:
	Rscript src/visualization/visualize.R

pipeline:
	Rscript main.R

mlflow:
	mlflow ui

clean:
	rm -rf data/raw/*.csv
	rm -rf data/processed/*.csv
	rm -rf data/external/*
	rm -rf data/interim/*
	rm -rf models/*.rds
	rm -rf models/*.txt
	rm -rf models/*.csv
	rm -rf reports/figures/*.png
	rm -rf mlruns/
	rm -rf mlartifacts/
	@echo "Cleaned generated files"
