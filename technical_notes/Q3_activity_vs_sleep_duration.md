# Q3 – Physical Activity and Sleep Duration

## Analytical Approach
The relationship between physical activity and sleep duration was analyzed at the user level to reduce bias from uneven daily recording frequency.

Given substantial variability in the number of sleep records per user, a sensitivity analysis was conducted across multiple data-consistency scenarios to assess the robustness of the results.

## Key Decisions
- User-level aggregation was applied to align activity and sleep metrics at the same analytical granularity.
- A multi-scenario sensitivity analysis was implemented to evaluate the impact of data sparsity:
  - Baseline analysis including all users with at least one sleep record.
  - A minimum threshold (≥5 sleep records) to ensure more stable averages.
  - A controlled window (5–20 records) to reduce the influence of high-volume outliers.
- Pearson correlation and linear trend visualization were used to assess linear association, acknowledging their limitations in high-variance behavioral data.

## Limitations
- The effective sample size decreases substantially as stricter data-quality filters are applied.
- Results from the controlled window scenario are highly sensitive due to a very small number of users.
- Sleep duration alone does not capture sleep quality or contextual factors (e.g., stress, work schedules, exercise timing).
- Observational wearable data prevents causal interpretation.

