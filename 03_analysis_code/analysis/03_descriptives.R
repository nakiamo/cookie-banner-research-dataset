# ============================================================================
# Script: 03_descriptives.R
# ============================================================================

# Load data
df <- readRDS("03_analysis_code/data_preparation/cleaned_data.rds")

# Choice distribution
cat("\n=== Choice Distribution ===\n")
print(prop.table(table(df$Choice_f)) * 100)

# Choice by experimental conditions
cat("\n=== Choice by Group and Memory ===\n")
print(prop.table(table(df$Choice_f, df$Group_f, df$Memory_f), c(2, 3)) * 100)

# Brand attitude (familiar conditions only)
if ("BA" %in% names(df)) {
  groups_12 <- df[df$Group %in% c(1, 2), ]
  ba_vals <- as.numeric(groups_12$BA[!is.na(groups_12$BA) & groups_12$BA != ""])
  
  if (length(ba_vals) > 0) {
    cat("\n=== Brand Attitude (Familiar Conditions) ===\n")
    cat("Mean: ", round(mean(ba_vals), 2), "\n")
    cat("SD: ", round(sd(ba_vals), 2), "\n")
    cat("Median: ", round(median(ba_vals), 2), "\n")
  }
}

cat("\nDescriptive statistics complete\n")
