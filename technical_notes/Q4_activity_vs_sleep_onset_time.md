# Q4 – Physical Activity and Sleep Onset Time

## Analytical Approach
Sleep onset latency is not directly available in the dataset. A proxy metric was engineered by calculating the difference between total time in bed and total minutes asleep, aggregated at the user level to reduce nightly noise.

This approach enables a consistent comparison between average physical activity and average sleep onset behavior.

## Key Decisions
- A proxy variable for sleep onset latency was created using:
  *(time in bed − minutes asleep)*, with negative values constrained to zero to avoid sensor inconsistencies.
- User-level aggregation was applied to stabilize individual sleep patterns before integration with activity metrics.
- Only users with complete activity and sleep data were retained via inner join to avoid partial-record bias.
- Activity was analyzed both as a continuous variable (steps) and as discretized activity levels to support interpretability.
- Pearson correlation and linear regression visualization were used to assess linear association.

## Limitations
- The final analytical sample is small (18 users), limiting statistical confidence.
- The proxy does not distinguish between time awake before sleep and nocturnal awakenings.
- Results are sensitive to individual outliers, particularly among highly active users.
- Lack of exercise timing data prevents evaluation of proximity effects (e.g., late-night workouts).

