# ============================================================================
# Script: 01_import_data.R
# Data: qualitrics-data-594.csv
# ============================================================================

# Load required packages
library(readr)

# Import data
data_file <- "01_data/qualitrics-data-594.csv"
df <- read_csv(data_file, show_col_types = FALSE)

# Create user_id if missing
if (!"user_id" %in% names(df)) {
  df$user_id <- 1:nrow(df)
}

# Validate required columns
required_cols <- c("Choice", "Group", "Memory", "PC", "PF")
missing <- setdiff(required_cols, names(df))
if (length(missing) > 0) {
  stop("Missing required columns: ", paste(missing, collapse = ", "))
}

# Display summary
cat("Data imported: ", nrow(df), " participants, ", ncol(df), " variables\n")

# Save for next step
saveRDS(df, "03_analysis_code/data_preparation/imported_data.rds")
