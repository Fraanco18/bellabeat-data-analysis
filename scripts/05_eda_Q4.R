# --------------------------------------------------
# Q4 - Activity Level and Sleep Quality Indicators
# Relationship between physical activity and sleep onset time
# Author: Franco Palomeque
# Date: 2025-12
# --------------------------------------------------

library(tidyverse)

# -----------------------------
# 1. Average daily steps per user
# -----------------------------

activity_summary <- activity_day_type %>%
  group_by(id) %>%
  summarise(
    avg_steps = mean(total_steps, na.rm = TRUE),
    .groups = "drop"
  )

# -----------------------------
# 2. Average time to fall asleep per user
# -----------------------------

sleep_summary <- sleep_day_filtered %>%
  mutate(
    minutes_awake_in_bed = pmax(
      total_time_in_bed - total_minutes_asleep,
      0
    )
  ) %>%
  group_by(id) %>%
  summarise(
    avg_minutes_to_fall_asleep = mean(minutes_awake_in_bed, na.rm = TRUE),
    .groups = "drop"
  )

# -----------------------------
# 3. Merge activity and sleep data
# -----------------------------

activity_sleep <- activity_summary %>%
  inner_join(sleep_summary, by = "id")

# Quick check
glimpse(activity_sleep)
summary(activity_sleep)

correlation_value <- cor(
  activity_sleep$avg_steps,
  activity_sleep$avg_minutes_to_fall_asleep,
  use = "complete.obs",
  method = "pearson"
)

correlation_value

# -----------------------------
# 4. Create activity levels (ORDERED)
# -----------------------------

activity_sleep <- activity_sleep %>%
  mutate(
    activity_level = case_when(
      avg_steps < 5000 ~ "Low activity",
      avg_steps >= 5000 & avg_steps < 10000 ~ "Moderate activity",
      avg_steps >= 10000 ~ "High activity"
    ),
    activity_level = factor(
      activity_level,
      levels = c("Low activity", "Moderate activity", "High activity")
    )
  )

# -----------------------------
# Option A: Relationship Between Physical Activity and Sleep Onset Time
# -----------------------------

ggplot(activity_sleep, aes(x = avg_steps, y = avg_minutes_to_fall_asleep)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "lm", se = FALSE) +
  annotate(
    "text",
    x = Inf, y = Inf,
    label = paste0("Pearson r = ", round(correlation_value, 2)),
    hjust = 1.1, vjust = 1.5
  ) +
  labs(
    title = "Relationship Between Physical Activity and Sleep Onset Time",
    x = "Average Daily Steps",
    y = "Average Minutes to Fall Asleep"
  ) +
  theme_minimal()

# -----------------------------
# Option B: Activity levels comparison
# -----------------------------

sleep_by_activity_level <- activity_sleep %>%
  group_by(activity_level) %>%
  summarise(
    avg_minutes_to_fall_asleep = mean(avg_minutes_to_fall_asleep, na.rm = TRUE),
    users = n(),
    .groups = "drop"
  )

ggplot(sleep_by_activity_level,
       aes(x = activity_level, y = avg_minutes_to_fall_asleep)) +
  geom_col() +
  labs(
    title = "Average Sleep Onset Time by Activity Level",
    x = "Activity Level",
    y = "Average Minutes to Fall Asleep"
  ) +
  theme_minimal()
