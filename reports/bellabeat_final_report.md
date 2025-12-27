# Bellabeat Case Study: Smart Device Usage Analysis

## Executive Summary

The objective of this analysis was to uncover non-intuitive patterns in how women use smart health devices, using Fitbit data as a proxy, to inform Bellabeat’s product development—particularly the Leaf tracker and Bellabeat app—and support its marketing strategy.

Multiple datasets related to physical activity, sleep behavior, heart rate, and calorie expenditure were analyzed to identify meaningful trends in real-world user behavior.

Key findings include specific metabolic advantages of high-intensity activity, physiological validation of activity classifications, and statistical evidence that sleep outcomes cannot be explained by step counts alone.

> **Note:** This document highlights key business insights. For the complete technical methodology, R code, and detailed statistical analysis, please refer to **`bellabeat_final_report_full.md`**.

------------------------------------------------------------------------

## Background & Business Task

### Business Context

Bellabeat is a wellness technology company founded in 2013 that develops smart devices and health applications designed specifically for women. Its product ecosystem includes wearables such as Leaf, Time, and Spring, along with the Bellabeat app, which tracks physical activity, sleep, heart rate, and daily habits.

Unlike many competitors, Bellabeat adopts a holistic, women-centered approach to health—combining physiological data with lifestyle insights, motivation, and self-care.

### Business Objective

The primary objective is to identify usage patterns and behavioral trends using publicly available Fitbit data to:

-   Understand how users engage with fitness and health tracking devices.
-   Identify key trends in physical activity, sleep behavior, and physiological metrics.
-   Generate actionable insights to support Bellabeat’s marketing strategy.

------------------------------------------------------------------------

## Data Sources & Methodology

### Data Sources

This analysis uses the **FitBit Fitness Tracker Data** (Mobius, Kaggle). The dataset contains anonymized data from 30 users (April–May 2016), covering physical activity, sleep, heart rate, and body weight. Although the data is not from Bellabeat users, it serves as a representative proxy for the wellness market.

### Reliability & Limitations

-   **Sample Size:** Small sample (n=30) with varying data consistency.
-   **Demographics:** Lack of confirmed gender or age variables.
-   **Context:** Data from 2016 may not reflect current wearable trends.

### Methodology

The analysis was conducted in **R**, focusing on data cleaning (duplicate removal, date standardization), metric validation, and exploratory visualization to derive the insights below.

------------------------------------------------------------------------

## Key Insights

### Insight 1: Physical Activity, Body Weight, and Heart Rate

Users with higher average daily step counts tended to show lower body weight values. Additionally, users in moderate and high activity categories exhibited marginally lower average heart rates than low-activity users.

**Why this matters:** This validates step-based activity tracking as a meaningful indicator of both physical movement and physiological engagement.

------------------------------------------------------------------------

### Insight 2: Activity Levels and Energy Expenditure

Energy expenditure is driven by intensity rather than the day of the week.

-   **Calories**: Users in high-activity categories burned approximately **26% more calories** than those in low-activity groups.
-   **Consistency**: There was **less than a 2% difference** in average daily steps between weekdays and weekends.

**Why this matters:** Marketing should encourage *intensity* and consistent movement habits, as user behavior is already stable across the week.

------------------------------------------------------------------------

### Insight 3: Physical Activity and Sleep Patterns

Daily step counts showed weak and inconsistent relationships with sleep outcomes.

-   **Correlation**: The association between steps and sleep duration is negligible (Pearson **r = -0.08** in high-quality data).
-   **Sleep Onset**: High-activity users often showed longer sleep onset times (the "wired but tired" phenomenon).
-   **Why this matters**: Sleep quality is influenced by factors beyond physical activity. Relying solely on step counts to predict sleep health creates inaccurate user expectations.

------------------------------------------------------------------------

## Business Recommendations

### 1. Reframe Sleep Messaging from Quantity to Quality

**Action:** Prioritize **Sleep Efficiency and Sleep Score** over total duration. Educate users that "more steps" does not automatically guarantee "more sleep."

### 2. Improve Data Integrity Through Gamification

**Action:** Implement **"Logging Streaks"** to reward users who consistently log data for 7+ days, addressing data gaps found in the analysis.

### 3. Smart User Segmentation & Wind-Down Alerts

**Action:** Trigger **"Wind-Down" notifications** 60 minutes before bed specifically for highly active users to combat the observed increase in sleep latency.

### 4. Optimize Exercise Timing

**Action:** Analyze user workout times to recommend earlier sessions if late-day intensity is disrupting sleep onset.

### 5. Maintain Weekend Engagement

**Action:** Introduce low-effort **"Sunday Recovery" challenges** to maintain engagement without requiring high-intensity output on rest days.

------------------------------------------------------------------------

## Conclusion

This analysis demonstrates that volume-based metrics (like steps) are insufficient for a holistic women's health strategy. By shifting focus to **quality-driven insights**—such as metabolic intensity and sleep efficiency—Bellabeat can strengthen user trust and differentiate itself from competitors that rely solely on generic activity tracking.
