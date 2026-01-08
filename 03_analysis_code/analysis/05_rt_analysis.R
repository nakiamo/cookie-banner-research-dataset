# ============================================================================
# Script: 05_rt_analysis.R
# Decision time (response time) analysis
# ============================================================================

# Load data
df <- readRDS("03_analysis_code/data_preparation/cleaned_data.rds")

# Identify decision time column
rt_col <- if ("Timesec_trim" %in% names(df)) "Timesec_trim" else
          if ("Timesec" %in% names(df)) "Timesec" else
          if ("TimeClick" %in% names(df)) "TimeClick" else NA

if (is.na(rt_col)) {
  cat("No decision time column found\n")
} else {
  # Convert to seconds
  rt_sec <- if (rt_col == "TimeClick") df[[rt_col]] / 1000 else df[[rt_col]]
  
  cat("\n=== Decision Time Summary ===\n")
  cat("N: ", sum(!is.na(rt_sec)), "\n")
  cat("Mean: ", round(mean(rt_sec, na.rm = TRUE), 2), "s\n")
  cat("Median: ", round(median(rt_sec, na.rm = TRUE), 2), "s\n")
  cat("SD: ", round(sd(rt_sec, na.rm = TRUE), 2), "s\n")
  
  # By Choice
  cat("\n=== Decision Time by Choice ===\n")
  by_choice <- aggregate(rt_sec, list(Choice = df$Choice_f), 
                         function(x) c(n = sum(!is.na(x)), 
                                      mean = mean(x, na.rm = TRUE),
                                      median = median(x, na.rm = TRUE)))
  print(by_choice)
  
  # By Group × Memory
  if (!any(is.na(df$Group_f)) && !any(is.na(df$Memory_f))) {
    cat("\n=== Decision Time by Group × Memory ===\n")
    by_gm <- aggregate(rt_sec, list(Group = df$Group_f, Memory = df$Memory_f), 
                       function(x) c(n = sum(!is.na(x)), 
                                    mean = mean(x, na.rm = TRUE)))
    print(by_gm)
  }
  
  cat("\nDecision time analysis complete\n")
}
