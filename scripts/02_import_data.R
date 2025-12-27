# --------------------------------------------------
# 02_import_data.R
# Data import and initial inspection
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

# 1. Import data
daily_activity <- read_csv(here("data", "raw", "dailyActivity_merged.csv"))
sleep_day <- read_csv(here("data", "raw", "sleepDay_merged.csv"))
daily_steps <- read_csv(here("data", "raw", "dailySteps_merged.csv"))
daily_calories <- read_csv(here("data", "raw", "dailyCalories_merged.csv"))
daily_intensities <- read_csv(here("data", "raw", "dailyIntensities_merged.csv"))
weight <- read_csv(here("data", "raw", "weightLogInfo_merged.csv"))
heartrate <- read_csv(here("data", "raw", "heartrate_seconds_merged.csv"))

# 2. Initial inspection
glimpse(daily_activity)
glimpse(sleep_day)
