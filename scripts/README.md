# Scripts

This directory contains the full analytical pipeline for the Bellabeat case study.

The workflow is structured sequentially:

- `01_setup.R`: Environment setup and package loading.
- `02_import_data.R`: Data import from raw sources.
- `03_cleaning.R`: Data cleaning and validation steps.
- `04_feature_engineering.R`: Creation of derived metrics and activity classifications.
- `05_eda.R`: **Pipeline orchestrator**. Sources all previous steps and runs the complete exploratory analysis in a reproducible manner.
- `05_eda_Q1.R` – `05_eda_Q6.R`: Question-specific exploratory analyses corresponding to each research question.

This structure reflects a modular, transparent, and fully reproducible analytical workflow.
