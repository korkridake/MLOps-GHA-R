# Titanic Dataset - Data Dictionary

## Overview

The Titanic dataset contains information about passengers aboard the RMS Titanic, which sank on April 15, 1912, after colliding with an iceberg during her maiden voyage from Southampton to New York City.

## Features

### Target Variable

| Variable | Type | Description | Values |
|----------|------|-------------|--------|
| **Survived** | Binary | Survival status | 0 = No, 1 = Yes |

### Predictor Variables

| Variable | Type | Description | Values/Range |
|----------|------|-------------|--------------|
| **Pclass** | Categorical | Passenger ticket class (proxy for socio-economic status) | 1 = 1st class, 2 = 2nd class, 3 = 3rd class |
| **Sex** | Categorical | Gender of passenger | male, female |
| **Age** | Continuous | Age of passenger in years | 0.42 - 80.0 |
| **SibSp** | Discrete | Number of siblings/spouses aboard | 0 - 8 |
| **Parch** | Discrete | Number of parents/children aboard | 0 - 6 |
| **Fare** | Continuous | Passenger fare in British pounds | 0.0 - 512.3 |
| **Embarked** | Categorical | Port of embarkation | C = Cherbourg, Q = Queenstown, S = Southampton |

## Variable Definitions

### Pclass
- **1st class**: Upper class passengers, typically wealthy individuals
- **2nd class**: Middle class passengers
- **3rd class**: Lower class passengers, including immigrants

### SibSp (Siblings/Spouses)
Includes:
- Sibling = brother, sister, stepbrother, stepsister
- Spouse = husband, wife (mistresses and fiancés were ignored)

### Parch (Parents/Children)
Includes:
- Parent = mother, father
- Child = daughter, son, stepdaughter, stepson
- Some children traveled only with a nanny, therefore parch=0 for them

### Embarked
The three main ports of embarkation:
- **C**: Cherbourg, France
- **Q**: Queenstown (now Cobh), Ireland
- **S**: Southampton, England

## Data Processing Notes

### Missing Values
- **Age**: Missing values imputed with median age
- **Fare**: Missing values imputed with median fare
- **Embarked**: Missing values replaced with 'S' (Southampton, the most common port)

### Data Quality
- Original dataset may contain some missing values
- All processed data has been cleaned and validated
- Categorical variables are encoded as factors for modeling

## Historical Context

The sinking of the Titanic is one of the most infamous shipwrecks in history. The ship was considered "unsinkable" but on April 15, 1912, after colliding with an iceberg, it sank, resulting in the deaths of more than 1,500 passengers and crew.

Survival was influenced by several factors:
- **"Women and children first"** protocol was largely followed
- **Passenger class** significantly affected survival rates
- **Location on the ship** and proximity to lifeboats
- **Crew assistance** available to different classes

## Source

The dataset is derived from publicly available sources and is commonly used for educational purposes in machine learning and data science.

## License

This dataset is in the public domain.
