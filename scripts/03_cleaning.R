# --------------------------------------------------
# 03_cleaning.R
# Data cleaning and standardization
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

# 1. Clean column names
daily_activity    <- clean_names(daily_activity)
sleep_day         <- clean_names(sleep_day)
daily_steps       <- clean_names(daily_steps)
daily_calories    <- clean_names(daily_calories)
daily_intensities <- clean_names(daily_intensities)
weight            <- clean_names(weight)
heartrate         <- clean_names(heartrate)

# 2. Convert date columns
daily_activity <- daily_activity %>%
  mutate(activity_date = mdy(activity_date))

sleep_day <- sleep_day %>%
  mutate(sleep_day = mdy_hms(sleep_day))

weight <- weight %>%
  mutate(date = mdy_hms(date))

heartrate <- heartrate %>%
  mutate(time = mdy_hms(time))

# --- Added: convert activity_day to Date ---
daily_calories <- daily_calories %>%
  mutate(activity_day = mdy(activity_day))

# 3. Remove duplicate rows
daily_activity    <- daily_activity %>% distinct()
sleep_day         <- sleep_day %>% distinct()
daily_steps       <- daily_steps %>% distinct()
daily_calories    <- daily_calories %>% distinct()
daily_intensities <- daily_intensities %>% distinct()
weight            <- weight %>% distinct()
heartrate         <- heartrate %>% distinct()

# 4. Handle missing values
weight <- weight %>% drop_na(weight_kg)

# 5. Standardize ID type
daily_activity$id <- as.character(daily_activity$id)
sleep_day$id      <- as.character(sleep_day$id)
weight$id         <- as.character(weight$id)
heartrate$id      <- as.character(heartrate$id)
daily_calories$id <- as.character(daily_calories$id)
daily_steps$id    <- as.character(daily_steps$id)
daily_intensities$id <- as.character(daily_intensities$id)

# 6. Export cleaned datasets for reuse in feature engineering and EDA

write_csv(daily_activity, here("data", "clean", "daily_activity_clean.csv"))
write_csv(sleep_day, here("data", "clean", "sleep_day_clean.csv"))
write_csv(daily_steps, here("data", "clean", "daily_steps_clean.csv"))
write_csv(daily_calories, here("data", "clean", "daily_calories_clean.csv"))
write_csv(weight, here("data", "clean", "weight_clean.csv"))

