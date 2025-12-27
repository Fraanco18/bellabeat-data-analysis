# --------------------------------------------------
# 05_eda.R
# EDA Pipeline Orchestrator
# Entry point for full reproducible analysis
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

# --------------------------------------------------
# Reproducible project pipeline
# --------------------------------------------------
source("scripts/01_setup.R")
source("scripts/02_import_data.R")
source("scripts/03_cleaning.R")
source("scripts/04_feature_engineering.R")

# Run each EDA question script

source("scripts/05_eda_Q1.R")
source("scripts/05_eda_Q2.R")
source("scripts/05_eda_Q3.R")
source("scripts/05_eda_Q4.R")
source("scripts/05_eda_Q5.R")
source("scripts/05_eda_Q6.R")