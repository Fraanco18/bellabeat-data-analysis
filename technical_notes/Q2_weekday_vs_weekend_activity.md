# Q2 – Activity Patterns by Day Type (Weekday vs. Weekend)

## Analytical Approach
Daily physical activity was analyzed by comparing average step counts between weekdays (Monday–Friday) and weekends (Saturday–Sunday).

A binary day-type classification (weekday vs. weekend) was engineered during the feature engineering stage to ensure consistency across the analytical pipeline and avoid redundant logic in downstream analyses.

## Key Decisions
- Day-type classification was reused from the feature engineering step to maintain a single source of truth.
- Daily-level data was retained to capture natural variability in user behavior.
- Mean and median step counts were examined to assess distribution symmetry before visualization.
- A bar chart was selected to facilitate direct comparison of average activity levels between categories.

## Limitations
- The effective sample is limited to users with repeated daily records, reducing generalizability.
- Daily step counts may reflect heterogeneous behaviors (e.g., leisure, commuting, structured exercise) that cannot be disentangled due to missing contextual variables.
- Observational data limits causal interpretation of weekday–weekend differences.
