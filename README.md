# Familiarity and Privacy Research Dataset

**Repository:** `familiarity-research-dataset`  
**Study:** The Role of Familiarity and Cookie Banner Interface in Privacy Consent Decisions  
**Authors:** Anonymized
**Date:** 2026

---

## Overview

This repository contains the complete research dataset, experimental materials, and analysis code for a study examining how website familiarity and cookie banner interface consistency influence privacy consent decisions. The study employed a 2×2 between-subjects factorial design with 594 Turkish adults (aged 18-35) and tested seven hypotheses investigating the effects of familiarity, consistency, cognitive load, privacy concerns, and privacy fatigue on cookie consent behavior.

---

## Description

This dataset contains data from an experimental study we conducted to examine how website familiarity and cookie banner interface consistency influence privacy consent decisions. We tested seven hypotheses (H1-H7) investigating how familiarity, consistency, cognitive load, privacy concerns, and privacy fatigue affect cookie consent behavior.
Research Hypotheses: H1 tested the main effects of familiarity and consistency. H2a and H2b examined how cognitive load moderates these effects. H3-H6 tested moderation by privacy concerns and fatigue. H7 examined the privacy paradox through the interaction between privacy concerns and fatigue.
Data Collection: We employed a 2×2 between-subjects factorial design with 594 Turkish adults aged 18-35. We randomly assigned participants to one of four conditions: (1) Familiar website + Consistent banner, (2) Familiar website + Mismatched banner, (3) Unfamiliar website + Consistent banner, (4) Unfamiliar website + Mismatched banner. Half of the participants completed a memory-based cognitive load task before making their cookie decision. We collected behavioral data (cookie choice: Accept/Reject/Manage/Other; decision time) automatically using JavaScript we embedded in the website prototypes and Qualtrics survey.
Notable Findings: Interface consistency significantly increased acceptance (H1b). Cognitive load moderated both familiarity effects (H2a) and consistency effects (H2b). Privacy concerns and fatigue moderated the effects across experimental groups (H3-H6). We confirmed the privacy paradox (H7): participants with high privacy concerns combined with high fatigue showed increased acceptance despite their concerns.
Data Interpretation: The dataset includes 594 participants with 35 variables: experimental conditions (Group, Memory), cookie choice, decision time, privacy concern and fatigue scales (PC1-PC4, PF1-PF5), demographics (age, gender, device), and brand attitude (for familiar conditions). For analyses that include decision time, we used N = 560 after excluding 34 participants who did not interact with the banner.
How to Use: Researchers can use this dataset to replicate our analyses using the provided R scripts, examine interaction effects, test alternative models, or extend the findings to other populations. The dataset enables investigation of privacy decision-making mechanisms, interface design effects, and cognitive processing in privacy contexts.

---
## Steps to Reproduce

Data Collection Protocol:

Participant Recruitment: We recruited Turkish adults aged 18-35 through online channels including university student networks and social media. Participants joined voluntarily and anonymously. We obtained informed consent electronically.
Experimental Design: We used a 2×2 between-subjects factorial design. We randomly assigned participants via Qualtrics Randomizer to four conditions: (1) Familiar website (Starbucks) + Consistent banner, (2) Familiar + Mismatched banner, (3) Unfamiliar website (Coffee Bean House) + Consistent banner, (4) Unfamiliar + Mismatched banner.
Cognitive Load Manipulation: Half of the participants completed a memory-based distraction task where they viewed three fictional coffee orders for 5 seconds each before website exposure. The other half served as the baseline group with no memory task.
Website Exposure: Participants viewed their assigned website prototype, which we embedded as an iframe in the Qualtrics survey. The cookie consent banner appeared center-screen with three options: Accept All, Reject All, and Manage Preferences.
Data Collection: We used JavaScript code embedded in the website prototypes to track: (a) cookie choice (Accept/Reject/Manage), and (b) decision time (milliseconds from page load to first click). JavaScript in Qualtrics received this data via postMessage API and stored it in embedded data fields (CookieChoice, TimeToFirstClick).
Survey Measures: We administered the Privacy Concern scale (4 items, 1-5), Privacy Fatigue scale (5 items, 1-5), Brand Attitude measure (familiar conditions only), and collected Demographics (age, gender, device type).

Instruments and Software:

Survey Platform: Qualtrics (online survey software)
Website Prototypes: Custom HTML/CSS/JavaScript (4 prototypes hosted on GitHub Pages)
Data Collection: JavaScript (postMessage API, URL parameters, localStorage)
Data Cleaning: R (version 4.4.1), RStudio
Statistical Analysis: R packages including nnet (multinomial logistic regression), base R (descriptive statistics), emmeans (predicted probabilities), and car (VIF diagnostics)

Workflow:

Data Export: We exported Qualtrics survey data as CSV
Data Cleaning: We imported the data into R and validated all required columns
Analysis: We conducted multinomial logistic regression for H1 and H3-H7, binary logistic regression for H2a/H2b, likelihood-ratio tests for model comparisons, and calculated predicted probabilities for interaction interpretation

Final Dataset: We retained 594 valid cases (560 for TimeSec analyses). We provide all scripts and website prototypes in the repository for replication.

---

## Repository Structure

```
familiarity-research-dataset/
├── 01_data/
│   └── qualitrics-data-594.csv          # Final dataset (N = 594)
├── 02_experimental_materials/
│   ├── javascript_code/                   # JavaScript for data collection
│   │   ├── website_tracking.js          # Cookie banner interaction tracking
│   │   ├── qualtrics_integration.js     # Qualtrics data reception
│   │   ├── memory_task.js               # Cognitive load manipulation
│   │   └── README_javascript.md         # JavaScript documentation
│   └── website_prototypes/               # Four experimental website prototypes
│       ├── starbucks_consistent/          # Group 1: Familiar + Consistent
│       ├── starbucks_mismatched/         # Group 2: Familiar + Mismatched
│       ├── coffeebean_consistent/        # Group 3: Unfamiliar + Consistent
│       └── coffeebean_mismatched/        # Group 4: Unfamiliar + Mismatched
└── 03_analysis_code/
    ├── data_preparation/                 # Data import and cleaning
    │   ├── 01_import_data.R
    │   └── 02_clean_prepare.R
    ├── analysis/                         # Statistical analysis
    │   ├── 03_descriptives.R
    │   ├── 04_models_comprehensive.R     # All hypotheses (H1-H7)
    │   └── 05_rt_analysis.R             # Decision time analysis
    └── README_code.md                    # Analysis code documentation
```

---

## Quick Start

### 1. Data

The dataset (`01_data/qualitrics-data-594.csv`) contains:
- **N = 594** participants
- **35 variables:** Experimental conditions, cookie choice, decision time, privacy scales, demographics
- **For analyses with decision time:** N = 560 (34 participants excluded who did not interact with banner)

### 2. Experimental Materials

**Website Prototypes:**
- Four HTML prototypes representing the 2×2 experimental design
- Each prototype folder contains `index.html` and associated assets (images)


**JavaScript Code:**
- Standalone JavaScript files for data collection and Qualtrics integration
- See `02_experimental_materials/javascript_code/README_javascript.md` for integration instructions

### 3. Analysis Code

**Required R Packages:**
```r
install.packages(c("readr", "dplyr", "nnet"))
```

**Run Analysis:**
```r
# Data preparation
source("03_analysis_code/data_preparation/01_import_data.R")
source("03_analysis_code/data_preparation/02_clean_prepare.R")

# Analysis
source("03_analysis_code/analysis/03_descriptives.R")
source("03_analysis_code/analysis/04_models_comprehensive.R")
source("03_analysis_code/analysis/05_rt_analysis.R")
```

See `03_analysis_code/README_code.md` for detailed documentation.

---

## Documentation

- **Analysis Code:** `03_analysis_code/README_code.md`
- **JavaScript:** `02_experimental_materials/javascript_code/README_javascript.md`

---

**Last Updated:** 2025-12-29

