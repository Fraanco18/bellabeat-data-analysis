# --------------------------------------------------
# Q5 - Heart Rate and Physical Activity Levels
# Average heart rate across different levels of physical activity
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

# Load required scripts
source("scripts/01_setup.R")
source("scripts/02_import_data.R")
source("scripts/03_cleaning.R")

# --------------------------------------------------
# Step 1: Calculate average heart rate per user
# --------------------------------------------------
# Heart rate data is recorded at a high frequency (seconds).
# To avoid bias from users with more records, we first compute
# the average heart rate per user.

heartrate_by_user <- heartrate %>%
  group_by(id) %>%
  summarise(
    avg_heart_rate = mean(value, na.rm = TRUE),
    .groups = "drop"
  )

# --------------------------------------------------
# Step 2: Merge heart rate data with average daily steps
# --------------------------------------------------
# Average daily steps are used as a proxy for overall physical
# activity level.

hr_steps <- avg_steps %>%
  inner_join(heartrate_by_user, by = "id")

# --------------------------------------------------
# Step 3: Classify users by physical activity level
# --------------------------------------------------
# Activity levels are defined based on commonly used step-count
# thresholds.

hr_steps <- hr_steps %>%
  # Remove users with missing average step data
  filter(!is.na(avg_daily_steps)) %>%
  
  # Classify users by physical activity level based on step count
  mutate(
    activity_level = case_when(
      avg_daily_steps < 5000 ~ "Low",
      avg_daily_steps >= 5000 & avg_daily_steps < 10000 ~ "Moderate",
      avg_daily_steps >= 10000 ~ "High"
    )
  )

# --------------------------------------------------
# Step 3.5: Correlation analysis between steps and heart rate
# --------------------------------------------------
# Pearson correlation is used to assess the linear relationship
# between average daily steps and average heart rate.

correlation_result <- cor(
  hr_steps$avg_daily_steps,
  hr_steps$avg_heart_rate,
  use = "complete.obs",
  method = "pearson"
)

correlation_result

# --------------------------------------------------
# Step 4: Calculate average heart rate by activity level
# --------------------------------------------------
# This aggregation allows comparison of physiological responses
# across different intensities of physical activity.

hr_by_activity <- hr_steps %>%
  group_by(activity_level) %>%
  summarise(
    avg_heart_rate = mean(avg_heart_rate, na.rm = TRUE),
    n_users = n(),
    .groups = "drop"
  ) %>%
  mutate(
    activity_level = factor(
      activity_level,
      levels = c("Low", "Moderate", "High")
    )
  )


# Display results
hr_by_activity

# --------------------------------------------------
# Step 5: Visualize average heart rate by activity level
# --------------------------------------------------
# A bar chart is used to clearly compare average heart rate across
# activity intensity groups.

ggplot(
  hr_by_activity,
  aes(
    x = factor(activity_level, levels = c("Low", "Moderate", "High")),
    y = avg_heart_rate
  )
) +
  geom_col() +
  labs(
    title = "Average Heart Rate by Physical Activity Level",
    x = "Physical Activity Level",
    y = "Average Heart Rate (bpm)"
  ) +
  theme_minimal()


# --------------------------------------------------
# Step 6: Scatter plot – Average Daily Steps vs Average Heart Rate
# --------------------------------------------------
# This visualization illustrates the relationship between physical
# activity (steps) and physiological response (heart rate).

ggplot(hr_steps, aes(x = avg_daily_steps, y = avg_heart_rate)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Relationship Between Daily Steps and Average Heart Rate",
    x = "Average Daily Steps",
    y = "Average Heart Rate (bpm)"
  ) +
  theme_minimal()