# Analysis Code Documentation

**Purpose:** This document explains how to run the analysis scripts.

---

## Overview

The analysis is organized into two main steps:

1. **Data Preparation** - Import and clean data
2. **Analysis** - Run descriptive statistics and model analyses

---

## Required R Packages

Install required packages before running:

```r
install.packages(c("readr", "dplyr", "nnet"))
```

Optional (for visualizations):
```r
install.packages("ggplot2")
```

---

## Running the Analysis

### Step 1: Data Preparation

Run scripts in order:

```r
# 1. Import data
source("03_analysis_code/data_preparation/01_import_data.R")

# 2. Clean and prepare data
source("03_analysis_code/data_preparation/02_clean_prepare.R")
```

**Output:**
- `imported_data.rds` - Raw imported data
- `cleaned_data.rds` - Cleaned data ready for analysis

### Step 2: Analysis

Run analysis scripts (order doesn't matter):

```r
# 3. Descriptive statistics
source("03_analysis_code/analysis/03_descriptives.R")

# 4. Model analysis (all hypotheses)
source("03_analysis_code/analysis/04_models_comprehensive.R")

# 5. Decision time analysis
source("03_analysis_code/analysis/05_rt_analysis.R")
```

---

## Script Descriptions

### 01_import_data.R
- Imports `qualitrics-data-594.csv`
- Validates required columns
- Creates user_id if missing
- Saves imported data

### 02_clean_prepare.R
- Creates factor variables (Choice_f, Group_f, Memory_f)
- Derives Familiarity and Consistency factors
- Centers continuous moderators (PCc, PFc)
- Processes decision time (Timesec_trim)
- Saves cleaned data

### 03_descriptives.R
- Choice distribution
- Choice by experimental conditions
- Brand attitude statistics (familiar conditions only)

### 04_models_comprehensive.R
- **H1:** Familiarity and Consistency effects
- **H2a/H2b:** Binary logistic regression (Familiarity/Consistency × Memory)
- **H3:** Group × Privacy Concern
- **H4:** Group × Privacy Concern × Memory (three-way interaction)
- **H5:** Group × Privacy Fatigue
- **H6:** Group × Privacy Fatigue × Memory (three-way interaction)
- **H7:** Privacy Concern × Privacy Fatigue (Privacy Paradox)

**Note:** All models include `Timesec_trim` as a control variable (as reported in the manuscript). Complete cases: N = 560 (34 participants who did not interact with banner excluded).

### 05_rt_analysis.R
- Decision time summary statistics
- Decision time by Choice
- Decision time by Group × Memory

---

## Data Files

- **Input:** `01_data/qualitrics-data-594.csv` (N = 594)
- **Intermediate:** `imported_data.rds`, `cleaned_data.rds`
- **Output:** Results printed to console

---

## Notes

- Scripts use relative paths (assume working directory is repository root)
- All scripts are standalone and can be run independently (after data preparation)
- Results are displayed in console; modify scripts to save outputs if needed
- Scripts are simplified to demonstrate the analysis workflow

---

**Last Updated:** 2025-12-29

