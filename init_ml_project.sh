#!/bin/bash

# Prompt user to input project name
read -p "Enter your project name: " project_name

# Prompt user to input the folder path where the project should be created
read -p "Enter the folder path where the project should be created (default is current directory): " folder_path
folder_path=${folder_path:-$(pwd)}  # Default to current directory if no input

# Create the full project path
project_path="$folder_path/$project_name"

# Create the base project folder
mkdir -p "$project_path"

# Create subfolders for the project structure
mkdir -p "$project_path/config"
mkdir -p "$project_path/data/raw"
mkdir -p "$project_path/data/processed"
mkdir -p "$project_path/models"
mkdir -p "$project_path/notebooks/eda"
mkdir -p "$project_path/notebooks/experiments"
mkdir -p "$project_path/outputs/plots"
mkdir -p "$project_path/outputs/reports"
mkdir -p "$project_path/src/data"
mkdir -p "$project_path/src/models"
mkdir -p "$project_path/src/utils"
mkdir -p "$project_path/tests"


# Create meaningful placeholder files
# Config
echo '{"example_key": "example_value"}' > "$project_path/config/config.json"
# Raw data placeholder
echo "Raw data files" > "$project_path/data/raw/README.md"
# Processed data placeholder
echo "Processed data files" > "$project_path/data/processed/README.md"
# Models placeholder
echo "Trained models" > "$project_path/models/README.md"

# Notebooks placeholders
touch "$project_path/notebooks/eda/0_eda.ipynb"
touch "$project_path/notebooks/experiments/experiment_template.ipynb"

# Outputs placeholders
echo "Output plots, images, and visualizations." > "$project_path/outputs/plots/README.md"
echo "Generated reports and summaries." > "$project_path/outputs/reports/README.md"

# Source code package placeholders
touch "$project_path/src/__init__.py"
touch "$project_path/src/data/__init__.py"
touch "$project_path/src/models/__init__.py"
touch "$project_path/src/utils/__init__.py"

# Create meaningful Python script placeholders in src directories
# src/data/preprocess.py
cat <<EOL > "$project_path/src/data/preprocess.py"
# preprocess.py
# This script contains functions for data preprocessing, such as handling missing values,
# feature scaling, and data transformations.
EOL

# src/data/loaders.py
cat <<EOL > "$project_path/src/data/loaders.py"
# loaders.py
# This script contains functions for data loading datasets from CSV, Parquet, or databases. 
# It also include functions for split datasets into training, validation, and test sets
EOL

# src/models/train.py
cat <<EOL > "$project_path/src/models/train.py"
# train.py
# This script defines the machine learning models.
EOL

# src/models/evaluate.py
cat <<EOL > "$project_path/src/models/evaluate.py"
# evaluate.py
# This script handles the evaluation of trained models and logs metrics.
EOL

# src/models/hp_tuning.py
cat <<EOL > "$project_path/src/models/hp_tuning.py"
# hp_tuning.py
# This script handles hyperparameter optimization.
EOL

# src/utils/helper.py
cat <<EOL > "$project_path/src/utils/helper.py"
# helper.py
# This script contains helper functions such as saving and loading models, logging, etc.
EOL

# src/utils/metrics.py
cat <<EOL > "$project_path/src/utils/metrics.py"
# metrics.py
# This script contains any custom evaluation metrics beyond basic ones.
EOL

# src/utils/visualization.py
cat <<EOL > "$project_path/src/utils/visualization.py"
# visualization.py
# This script contains functions for plot data and model performances.
EOL

# tests/test_placeholder.py
cat <<EOL > "$project_path/tests/test_placeholder.py"
# test_placeholder.py
# This script is a placeholder for unit tests.

def test_sample():
    \"\"\"An example test function.\"\"\"
    assert True

if __name__ == "__main__":
    print("Running tests...")
EOL

# train.py
cat <<EOL > "$project_path/train.py"
# This script is designed to be executed inside the SageMaker training environment. 
# It handles data loading, model training, and storing the trained model to S3.
EOL

# inference.py
cat <<EOL > "$project_path/inference.py"
# This script is meant to be used inside a SageMaker endpoint. 
# It loads the trained model, handle inference requests, and return predictions
EOL

# inference_helper.py
cat <<EOL > "$project_path/inference_helper.py"
# This script contains helper functions for loading the model and preprocessing data for inference.
EOL

# Create README.md with a placeholder
cat <<EOL > "$project_path/README.md"
# $project_name

## Project Overview
A brief description of your project, its purpose, and goals.

## Project Structure
\`\`\`
$project_name/
├── config/                # Configuration files
├── data/                  # Raw and processed data storage
├── models/                # Directory for storing trained models
├── notebooks/             # EDA and experiment notebooks
│   ├── eda/               # EDA notebooks
│   └── experiments/       # Experiment notebooks
├── outputs/               # Outputs such as plots and reports
├── src/                   # Source code for data processing and modeling
│   ├── data/              # Data processing scripts
│   ├── models/            # Model training scripts
│   ├── utils/             # Utility functions
├── tests/                 # Unit tests
├── README.md              # Project documentation
└── .gitignore             # Git ignore file
\`\`\`

## Installation
Instructions on how to set up the project.

## Usage
How to use the project, run experiments, or train models.

## Contributing
Guidelines for contributing to the project.

## License
The license under which the project is distributed.
EOL

# Create a .gitignore file
cat <<EOL > "$project_path/.gitignore"
# Byte-compiled / optimized / DLL files
__pycache__/
*.py[cod]

# Virtual environments
venv/
env/
.venv/

# Data files
data/raw/
data/processed/
*.csv
*.parquet

# Models and outputs
models/
outputs/plots/
outputs/reports/
*.h5
*.hdf5
*.ckpt
*.pkl
*.joblib

# Jupyter Notebook checkpoints
.ipynb_checkpoints/

# Temporary and log files
*.log
*.tmp
*.cache
.DS_Store

# MLflow
mlruns/
EOL

# Ask the user if they want to create a Mamba-based Conda environment
read -p "Do you want to create a Mamba-based Conda environment? (yes/no): " create_env
if [ "$create_env" = "yes" ]; then
    # Ask for the environment name (env_name)
    read -p "Enter the environment name (default is 'ml_env'): " env_name
    env_name=${env_name:-ml_env}

    # Ask for the Python version (default to 3.9)
    read -p "Enter the Python version (default is 3.9): " python_version
    python_version=${python_version:-3.9}

    # Create the environment using Mamba
    echo "Creating Mamba environment..."
    mamba create -n "$env_name" python="$python_version" -y

    echo "Mamba environment '$env_name' with Python $python_version created!"

    # Activate the environment and install required packages (example packages)
    mamba activate "$env_name"
    mamba install numpy pandas scikit-learn matplotlib jupyter -y

    # Optionally, export the environment to a YAML file
    mamba env export --no-builds | grep -v "^prefix: " > "$project_path/requirements.yml"
    echo "Environment exported to $project_path/requirements.yml"
fi

echo "Project structure for $project_name created at $project_path!"
