# Q5 – Heart Rate and Activity Intensity

## Analytical Approach
Heart rate data is recorded at a very high frequency, producing millions of observations. To avoid overweighting users with denser recordings, heart rate values were aggregated into a single average per user before integration with activity data.

This user-level physiological profile enables a fair comparison across individuals with different tracking intensity.

## Key Decisions
- Heart rate measurements were collapsed to an average per user to prevent bias from unequal recording density.
- Activity and heart rate data were merged using inner join to retain only users with complete records.
- Pearson correlation was used to assess the linear relationship between step count and average heart rate.
- Users were categorized into Low, Moderate, and High activity levels to support group-level interpretation.
- Factor levels were explicitly ordered to preserve logical intensity progression in summaries and plots.

## Key Findings
- A weak negative correlation was observed (r = -0.136), indicating that higher activity levels are associated with slightly lower average heart rates.
- The Moderate activity group exhibited the lowest average heart rate, suggesting potential cardiovascular efficiency associated with sustained, moderate-intensity movement.
- Significant dispersion across individuals indicates that step count alone is insufficient to explain heart rate variability.

## Limitations
- The final merged sample includes only 14 users, limiting generalizability.
- Averages are sensitive to outliers due to the small user base.
- Critical physiological and demographic variables (age, fitness level, health conditions) are unavailable.

