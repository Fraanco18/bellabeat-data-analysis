# --------------------------------------------------
# 05_eda_Q2.R
# Exploratory Data Analysis - Question 2
# Description: Examine the level of physical activity during the week and weekend 
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

library(dplyr)
library(ggplot2)

# --------------------------------------------------
# Q2: Are users more physically active on weekdays or weekends?http://127.0.0.1:30974/graphics/3c7f4404-4722-4bc0-9229-ab08c98f1583.png
# Objective:
# Compare average daily step counts between weekdays and weekends
# to identify behavioral differences in physical activity patterns.
# --------------------------------------------------

# NOTE:
# The weekday vs weekend classification (week_part) was created
# during the feature engineering stage (04_feature_engineering.R)
# and is reused here to ensure consistency across analyses.

activity_day_type <- daily_activity

# --------------------------------------------------
# Validation summary (exploratory, not shown in final report)
# --------------------------------------------------

activity_day_type %>%
  group_by(week_part) %>%
  summarise(
    avg_steps = round(mean(total_steps, na.rm = TRUE), 0),
    median_steps = round(median(total_steps, na.rm = TRUE), 0),
    n = n(),
    .groups = "drop"
  )

# --------------------------------------------------
# Dataset for visualization
# --------------------------------------------------

steps_by_day_type <- activity_day_type %>%
  group_by(id, week_part) %>%
  summarise(
    avg_steps_user = mean(total_steps, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  group_by(week_part) %>%
  summarise(
    avg_steps = round(mean(avg_steps_user), 0),
    .groups = "drop"
  )


# --------------------------------------------------
# Visualization: Weekdays vs Weekends
# --------------------------------------------------

ggplot(steps_by_day_type, aes(x = week_part, y = avg_steps)) +
  geom_col(width = 0.6, fill = "steelblue") +
  geom_text(
    aes(label = avg_steps),
    vjust = -0.5,
    size = 4
  ) +
  labs(
    title = "Average Daily Steps: Weekdays vs Weekends",
    x = NULL,
    y = "Average Daily Steps"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold")
  )