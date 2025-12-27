# --------------------------------------------------
# Q6 - Energy Expenditure and Physical Activity Levels
# Average calories burned across different levels
# of physical activity
#
# Sub-question:
# Comparison of calorie expenditure between weekdays
# and weekends
#
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

# Load required scripts
source("scripts/01_setup.R")
source("scripts/02_import_data.R")
source("scripts/03_cleaning.R")
source("scripts/04_feature_engineering.R")

# --------------------------------------------------
# Step 1: Calculate average daily calories per user
# --------------------------------------------------
# Calorie data is recorded daily. To ensure fair comparison
# between users, we first calculate each user's average
# daily calorie expenditure.

avg_calories <- daily_calories %>%
  group_by(id) %>%
  summarise(
    avg_daily_calories = mean(calories, na.rm = TRUE),
    .groups = "drop"
  )

# --------------------------------------------------
# Step 2: Merge calorie data with average daily steps
# --------------------------------------------------
# Average daily steps are used as a proxy for overall
# physical activity level.

energy_activity <- avg_steps %>%
  inner_join(avg_calories, by = "id")

# --------------------------------------------------
# Step 3: Classify users by physical activity level
# --------------------------------------------------
# Activity levels are defined based on commonly used
# step-count thresholds.

energy_activity <- energy_activity %>%
  filter(!is.na(avg_daily_steps)) %>%
  mutate(
    activity_level = case_when(
      avg_daily_steps < 5000 ~ "Low",
      avg_daily_steps >= 5000 & avg_daily_steps < 10000 ~ "Moderate",
      avg_daily_steps >= 10000 ~ "High"
    )
  )

# --------------------------------------------------
# Step 4: Calculate average calories burned by activity level
# --------------------------------------------------
# This aggregation allows comparison of energy expenditure
# across different levels of physical activity.

calories_by_activity <- energy_activity %>%
  group_by(activity_level) %>%
  summarise(
    avg_calories = mean(avg_daily_calories, na.rm = TRUE),
    n_users = n(),
    .groups = "drop"
  )

# Display results
calories_by_activity

# --------------------------------------------------
# Step 5: Visualize average calories burned by activity level
# --------------------------------------------------
# A bar chart is used to compare average daily calorie
# expenditure across activity levels.

ggplot(
  calories_by_activity,
  aes(
    x = factor(activity_level, levels = c("Low", "Moderate", "High")),
    y = avg_calories
  )
) +
  geom_col() +
  geom_text(
    aes(label = round(avg_calories)),
    vjust = -0.5,
    size = 4
  ) +
  labs(
    title = "Average Daily Calories Burned by Physical Activity Level",
    x = "Physical Activity Level",
    y = "Average Daily Calories"
  ) +
  theme_minimal()




# --------------------------------------------------
# Step 6: Sub-question – Weekday vs Weekend comparison
# --------------------------------------------------
# To complement the analysis, we examine whether energy
# expenditure differs between weekdays and weekends.
# The weekday/weekend classification is reused from
# feature engineering to ensure consistency.

# Create lookup table for day type
day_lookup <- daily_activity %>%
  select(id, activity_date, week_part)

# Join calorie data with weekday/weekend information
daily_calories_daytype <- daily_calories %>%
  rename(activity_date = activity_day) %>%
  left_join(day_lookup, by = c("id", "activity_date"))

# --------------------------------------------------
# Step 7: Calculate average calories per user by day type
# --------------------------------------------------
# Averaging at the user level prevents bias from users
# with more recorded days.

calories_daytype_user <- daily_calories_daytype %>%
  group_by(id, week_part) %>%
  summarise(
    avg_daily_calories = mean(calories, na.rm = TRUE),
    .groups = "drop"
  )

# --------------------------------------------------
# Step 8: Compare calorie expenditure by day type
# --------------------------------------------------
calories_daytype_summary <- calories_daytype_user %>%
  group_by(week_part) %>%
  summarise(
    avg_calories = mean(avg_daily_calories, na.rm = TRUE),
    n_users = n(),
    .groups = "drop"
  )

# Display results
calories_daytype_summary

# --------------------------------------------------
# Step 9: Visualize weekday vs weekend calorie expenditure
# --------------------------------------------------

ggplot(calories_daytype_summary,
       aes(x = week_part, y = avg_calories)) +
  geom_col() +
  geom_text(
    aes(label = round(avg_calories)),
    vjust = -0.5,
    size = 4
  ) +
  labs(
    title = "Average Daily Calories Burned: Weekdays vs Weekends",
    x = "Day Type",
    y = "Average Daily Calories"
  ) +
  theme_minimal()

# --------------------------------------------------
# Key Findings:
# - Users with higher physical activity levels burn
#   more calories on average.
# - Despite this, average calorie expenditure between
#   weekdays and weekends shows minimal differences.
# --------------------------------------------------