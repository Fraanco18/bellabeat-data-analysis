# --------------------------------------------------
# 04_feature_engineering.R
# Feature engineering for analysis
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

library(lubridate)

daily_activity <- daily_activity %>%
  mutate(
    # Day of week (English, ordered, system-independent)
    weekday = factor(
      wday(activity_date, week_start = 1),
      levels = 1:7,
      labels = c(
        "Monday", "Tuesday", "Wednesday",
        "Thursday", "Friday", "Saturday", "Sunday"
      )
    ),
    
    # Weekday vs Weekend
    week_part = if_else(
      weekday %in% c("Saturday", "Sunday"),
      "Weekend",
      "Weekday"
    ),
    
    # Activity level based on steps
    activity_level = case_when(
      total_steps < 5000 ~ "Sedentary",
      total_steps < 7500 ~ "Lightly Active",
      total_steps < 10000 ~ "Fairly Active",
      TRUE ~ "Very Active"
    ),
    
    # Total active minutes
    active_minutes = very_active_minutes +
      fairly_active_minutes +
      lightly_active_minutes,
    
    # Sedentary ratio
    sedentary_ratio = sedentary_minutes /
      na_if(active_minutes + sedentary_minutes, 0)
  )
