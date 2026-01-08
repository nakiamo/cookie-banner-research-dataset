# ============================================================================
# Script: 02_clean_prepare.R
# ============================================================================

# Load data
df <- readRDS("03_analysis_code/data_preparation/imported_data.rds")

# Create factor variables
df$Choice_f <- factor(df$Choice, levels = c(1, 2, 3, 4),
                      labels = c("Accept", "Reject", "Manage", "Other"))

df$Group_f <- factor(df$Group, levels = c(1, 2, 3, 4),
                     labels = c("Familiar_Consistent", "Familiar_Mismatched",
                                "Unfamiliar_Consistent", "Unfamiliar_Mismatched"))

df$Memory_f <- factor(df$Memory, levels = c(1, 2),
                      labels = c("WithMemory", "NoMemory"))

# Derive Familiarity and Consistency
df$Familiarity_f <- factor(ifelse(df$Group %in% c(1, 2), "Familiar", "Unfamiliar"),
                           levels = c("Familiar", "Unfamiliar"))

df$Consistency_f <- factor(ifelse(df$Group %in% c(1, 3), "Consistent", "Mismatched"),
                           levels = c("Consistent", "Mismatched"))

# Center continuous moderators
df$PCc <- df$PC - mean(df$PC, na.rm = TRUE)
df$PFc <- df$PF - mean(df$PF, na.rm = TRUE)

# Process decision time (if available)
if ("Timesec" %in% names(df)) {
  # Remove impossible fast clicks (< 0.3s) and cap outliers
  ts <- df$Timesec
  ts[ts < 0.3] <- NA
  p99 <- quantile(ts, 0.99, na.rm = TRUE)
  if (is.finite(p99)) ts[ts > p99] <- p99
  df$Timesec_trim <- ts
  
  # Create speed bands
  qs <- quantile(df$Timesec_trim, probs = c(0.33, 0.67), na.rm = TRUE)
  if (all(is.finite(qs))) {
    df$SpeedBand_tertile <- cut(df$Timesec_trim,
                                breaks = c(-Inf, qs[1], qs[2], Inf),
                                labels = c("Fast", "Medium", "Slow"),
                                include.lowest = TRUE)
  }
}

cat("Data prepared: ", nrow(df), " participants\n")

# Complete cases for models WITH TimeSec (N = 560)
complete_with_timesec <- sum(complete.cases(df[, c("Choice_f", "Group_f", "Memory_f", "PCc", "PFc", "Timesec_trim")]))
cat("Complete cases (with TimeSec): ", complete_with_timesec, "\n")

# Complete cases for models WITHOUT TimeSec (N = 594)
complete_without_timesec <- sum(complete.cases(df[, c("Choice_f", "Group_f", "Memory_f", "PCc", "PFc")]))
cat("Complete cases (without TimeSec): ", complete_without_timesec, "\n")

# Save for analysis
saveRDS(df, "03_analysis_code/data_preparation/cleaned_data.rds")
