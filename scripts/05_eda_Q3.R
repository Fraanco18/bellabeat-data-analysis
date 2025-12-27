# --------------------------------------------------
# 05_eda_Q3.R
# Exploratory Data Analysis - Question 3
# Description: Investigate the relationship between sleep patterns and activity level
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

library(dplyr)
library(ggplot2)

# --------------------------------------------------
# Q3: Relationship between physical activity and sleep duration
# Approach:
# A) No filtering (baseline)
# B) Minimum data threshold (≥ 5 sleep records)
# C) Controlled window (5–20 sleep records)
# --------------------------------------------------

# Exploratory: number of sleep records per user
sleep_counts <- sleep_day %>%
  group_by(id) %>%
  summarise(
    sleep_records = n(),
    valid_records = sum(!is.na(total_minutes_asleep)),
    .groups = "drop"
  )

summary(sleep_counts$sleep_records)

# Distribution of sleep records

ggplot(sleep_counts, aes(x = reorder(factor(id), sleep_records), y = sleep_records)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Number of Sleep Records per User",
    x = "User ID",
    y = "Sleep Records"
  ) +
  theme_minimal()


# -------------------------------
# A) No filtering (baseline)
# -------------------------------

steps_sleep_all <- sleep_day %>%
  group_by(id) %>%
  summarise(
    avg_minutes_asleep = mean(total_minutes_asleep, na.rm = TRUE),
    sleep_days = n(),
    .groups = "drop"
  ) %>%
  inner_join(avg_steps, by = "id")

# Visualization (Unfiltered)

ggplot(steps_sleep_all,
       aes(x = avg_daily_steps, y = avg_minutes_asleep)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Daily Steps vs Sleep Duration (Unfiltered data)",
    x = "Average Daily Steps",
    y = "Average Minutes Asleep"
  ) +
  theme_minimal()

cor(
  steps_sleep_all$avg_daily_steps,
  steps_sleep_all$avg_minutes_asleep,
  use = "complete.obs"
)

# -------------------------------
# B) Minimum threshold (≥ 5 days)
# -------------------------------

valid_sleep_ids <- sleep_counts %>%
  filter(sleep_records >= 5) %>%
  pull(id)

sleep_day_filtered <- sleep_day %>%
  filter(id %in% valid_sleep_ids)

sleep_avg_filtered <- sleep_day_filtered %>%
  group_by(id) %>%
  summarise(
    avg_minutes_asleep = mean(total_minutes_asleep, na.rm = TRUE),
    sleep_days = n(),
    .groups = "drop"
  )

steps_sleep_filtered <- avg_steps %>%
  inner_join(sleep_avg_filtered, by = "id")

# Visualization (filtered)

ggplot(steps_sleep_filtered,
       aes(x = avg_daily_steps, y = avg_minutes_asleep)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Daily Steps vs Sleep Duration (Users with ≥ 5 Sleep Records)",
    x = "Average Daily Steps",
    y = "Average Minutes Asleep"
  ) +
  theme_minimal()

cor(
  steps_sleep_filtered$avg_daily_steps,
  steps_sleep_filtered$avg_minutes_asleep,
  use = "complete.obs"
)

# -------------------------------
# C) Controlled window (5–20 days)
# -------------------------------

sleep_counts_window <- sleep_counts %>%
  filter(sleep_records >= 5, sleep_records <= 20)

sleep_day_window <- sleep_day %>%
  filter(id %in% sleep_counts_window$id)

sleep_avg_window <- sleep_day_window %>%
  group_by(id) %>%
  summarise(
    avg_minutes_asleep = mean(total_minutes_asleep, na.rm = TRUE),
    sleep_days = n(),
    .groups = "drop"
  )

steps_sleep_window <- avg_steps %>%
  inner_join(sleep_avg_window, by = "id")

# Visualization (Controlled window (5-20 days))

ggplot(steps_sleep_window,
       aes(x = avg_daily_steps, y = avg_minutes_asleep)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Daily Steps vs Sleep Duration (Controlled Window: 5–20 Days)",
    x = "Average Daily Steps",
    y = "Average Minutes Asleep"
  ) +
  theme_minimal()

cor(
  steps_sleep_window$avg_daily_steps,
  steps_sleep_window$avg_minutes_asleep,
  use = "complete.obs"
)

# --------------------------------------------------
# Summary (internal conclusion):
# Across all approaches, the relationship between physical activity
# (daily steps) and sleep duration is weak and sensitive to
# data availability and filtering criteria.
# --------------------------------------------------