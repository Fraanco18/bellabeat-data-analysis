# Q6 – Energy Expenditure and Physical Activity Patterns

## Analytical Approach
Daily calorie expenditure was analyzed at the user level to prevent bias from unequal recording frequency. Average daily calories were first computed per user and then integrated with activity metrics to evaluate differences across activity intensity levels and day types.

This two-stage aggregation ensures that each user contributes equally to group-level comparisons.

## Key Decisions
- Calorie data were normalized at the user level before group aggregation to avoid overrepresenting users with more recorded days.
- Users were categorized into Low, Moderate, and High activity levels based on average daily steps.
- Group-level averages were computed only after user-level normalization.
- A secondary aggregation was applied for weekday vs weekend comparisons to preserve individual behavioral patterns.
- Bar charts were used to highlight categorical contrasts and relative magnitude differences.

## Key Findings
- A strong monotonic increase in calorie expenditure was observed across activity levels.
- High-activity users burned approximately 536 more calories per day than low-activity users.
- Calorie expenditure remained remarkably stable between weekdays and weekends, with a negligible difference (~14 calories).
- Results suggest that total energy output is driven more by activity intensity than by day-of-week effects.

## Limitations
- The final analysis is based on 33 unique users, limiting population-level generalization.
- Basal metabolic rate (BMR) drivers such as age, body composition, and gender are unavailable.
- Non-step-based activities and contextual energy expenditure are not captured in the dataset.

