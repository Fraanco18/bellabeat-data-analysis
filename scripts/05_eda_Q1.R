# --------------------------------------------------
# 05_eda_Q1.R
# Exploratory Data Analysis - Question 1
# Description: Analyze daily activity per user
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

library(dplyr)
library(ggplot2)

# --------------------------------------------------
# Overview: Average steps by day of the week
# --------------------------------------------------

avg_steps_by_weekday <- daily_activity %>%
  group_by(weekday) %>%
  summarise(
    avg_steps = mean(total_steps, na.rm = TRUE),
    .groups = "drop"
  )

avg_steps_by_weekday

# Distribution of daily steps by weekday

ggplot(daily_activity, aes(x = weekday, y = total_steps)) +
  geom_boxplot() +
  labs(
    title = "Distribution of Daily Steps by Weekday",
    x = "Day of the Week",
    y = "Total Steps"
  ) +
  theme_minimal()

# --------------------------------------------------
# Q1: Is there a relationship between physical activity and body weight?
# Note: Weight data is available for a limited subset of users.
# Analysis is descriptive and exploratory.
# --------------------------------------------------

# Average daily steps per user
avg_steps <- daily_activity %>%
  group_by(id) %>%
  summarise(
    avg_daily_steps = mean(total_steps, na.rm = TRUE),
    .groups = "drop"
  )

# Average body weight per user
avg_weight <- weight %>%
  group_by(id) %>%
  summarise(
    avg_weight_kg = mean(weight_kg, na.rm = TRUE),
    .groups = "drop"
  )

# Merge activity and weight data
steps_weight <- avg_steps %>%
  inner_join(avg_weight, by = "id")

# Basic validation
summary(steps_weight)

# Visualization: steps vs weight

ggplot(steps_weight, aes(x = avg_daily_steps, y = avg_weight_kg)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Average Daily Steps vs Average Body Weight",
    x = "Average Daily Steps",
    y = "Average Weight (kg)"
  ) +
  theme_minimal()

# Correlation (descriptive)
cor(
  steps_weight$avg_daily_steps,
  steps_weight$avg_weight_kg,
  use = "complete.obs"
)