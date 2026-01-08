# ============================================================================
# Script: 04_models_comprehensive.R
# ============================================================================

library(nnet)

# Load data
df <- readRDS("03_analysis_code/data_preparation/cleaned_data.rds")

# Complete cases WITH TimeSec (N = 560) - as reported in manuscript
# Note: 34 participants who did not interact with banner excluded
df_complete <- df[complete.cases(df[, c("Choice_f", "Group_f", "Memory_f", "PCc", "PFc", "Timesec_trim")]), ]
cat("Complete cases (with TimeSec): ", nrow(df_complete), " of ", nrow(df), "\n")

# Helper function for likelihood-ratio tests
lr_test <- function(m1, m2) {
  out <- try(anova(m1, m2, test = "Chisq"), silent = TRUE)
  if (inherits(out, "try-error")) return(list(chi_sq = NA, df = NA, p = NA))
  if (nrow(out) >= 2 && "Pr(Chi)" %in% colnames(out)) {
    return(list(chi_sq = as.numeric(tail(out$`LR stat.`, 1)),
                df = as.numeric(tail(out$`   Df`, 1)),
                p = as.numeric(tail(out$`Pr(Chi)`, 1))))
  }
  return(list(chi_sq = NA, df = NA, p = NA))
}

# H1: Familiarity and Consistency
# Note: Timesec_trim included as control variable (as reported in manuscript)
cat("\n=== H1: Familiarity and Consistency ===\n")
fit_h1_full <- multinom(Choice_f ~ Familiarity_f * Consistency_f * Memory_f * PCc * PFc + Timesec_trim, 
                         data = df_complete, trace = FALSE)
fit_h1_no_fam <- multinom(Choice_f ~ Consistency_f * Memory_f * PCc * PFc + Timesec_trim, 
                           data = df_complete, trace = FALSE)
fit_h1_no_con <- multinom(Choice_f ~ Familiarity_f * Memory_f * PCc * PFc + Timesec_trim, 
                           data = df_complete, trace = FALSE)
fit_h1_no_int <- multinom(Choice_f ~ Familiarity_f + Consistency_f + Memory_f * PCc * PFc + Timesec_trim, 
                           data = df_complete, trace = FALSE)

h1a <- lr_test(fit_h1_no_fam, fit_h1_full)
h1b <- lr_test(fit_h1_no_con, fit_h1_full)
h1c <- lr_test(fit_h1_no_int, fit_h1_full)

cat("H1a (Familiarity): χ² =", round(h1a$chi_sq, 2), ", p =", format.pval(h1a$p, digits = 3), "\n")
cat("H1b (Consistency): χ² =", round(h1b$chi_sq, 2), ", p =", format.pval(h1b$p, digits = 3), "\n")
cat("H1c (Interaction): χ² =", round(h1c$chi_sq, 2), ", p =", format.pval(h1c$p, digits = 3), "\n")

# H2a and H2b: Binary Logistic Regression
cat("\n=== H2a and H2b: Binary Logistic Regression ===\n")
df_bin <- df_complete[df_complete$Choice_f != "Other", ]
df_bin$Y_accept <- ifelse(df_bin$Choice_f == "Accept", 1, 0)

# H2a: Familiarity × Memory
# Note: Timesec_trim included as control variable (as reported in manuscript)
fit_h2a_base <- glm(Y_accept ~ Familiarity_f + Memory_f + PCc + PFc + Timesec_trim, 
                     data = df_bin, family = binomial())
fit_h2a_int <- glm(Y_accept ~ Familiarity_f * Memory_f + PCc + PFc + Timesec_trim, 
                     data = df_bin, family = binomial())
h2a_lr <- anova(fit_h2a_base, fit_h2a_int, test = "Chisq")
h2a_p <- if (nrow(h2a_lr) >= 2) as.numeric(tail(h2a_lr$`Pr(>Chi)`, 1)) else NA
cat("H2a (Familiarity × Memory): p =", format.pval(h2a_p, digits = 3), "\n")

# H2b: Consistency × Memory
# Note: Timesec_trim included as control variable (as reported in manuscript)
fit_h2b_base <- glm(Y_accept ~ Consistency_f + Memory_f + PCc + PFc + Timesec_trim, 
                     data = df_bin, family = binomial())
fit_h2b_int <- glm(Y_accept ~ Consistency_f * Memory_f + PCc + PFc + Timesec_trim, 
                     data = df_bin, family = binomial())
h2b_lr <- anova(fit_h2b_base, fit_h2b_int, test = "Chisq")
h2b_p <- if (nrow(h2b_lr) >= 2) as.numeric(tail(h2b_lr$`Pr(>Chi)`, 1)) else NA
cat("H2b (Consistency × Memory): p =", format.pval(h2b_p, digits = 3), "\n")

# H3: Group × Privacy Concern
# Note: Timesec_trim included as control variable (as reported in manuscript)
cat("\n=== H3: Group × Privacy Concern ===\n")
fit_h3_full <- multinom(Choice_f ~ Group_f * PCc + Memory_f + PFc + Timesec_trim, 
                         data = df_complete, trace = FALSE)
fit_h3_no_int <- multinom(Choice_f ~ Group_f + PCc + Memory_f + PFc + Timesec_trim, 
                           data = df_complete, trace = FALSE)
h3 <- lr_test(fit_h3_no_int, fit_h3_full)
cat("H3 (Group × PC): χ² =", round(h3$chi_sq, 2), ", p =", format.pval(h3$p, digits = 3), "\n")

# H4: Group × PC × Memory (three-way interaction)
# Note: Timesec_trim included as control variable (as reported in manuscript)
# Model includes all lower-order interactions up to the three-way term
cat("\n=== H4: Group × PC × Memory ===\n")
fit_h4_full <- multinom(Choice_f ~ Group_f * PCc * Memory_f + Group_f * PFc + 
                          Memory_f * PFc + PCc * PFc +
                          Group_f * Memory_f * PFc + Group_f * PCc * PFc +
                          Memory_f * PCc * PFc + Group_f * Memory_f * PCc * PFc + Timesec_trim,
                          data = df_complete, trace = FALSE)
fit_h4_no_int <- multinom(Choice_f ~ Group_f * PCc + Group_f * Memory_f + Group_f * PFc + 
                             Memory_f * PCc + Memory_f * PFc + PCc * PFc +
                             Group_f * Memory_f * PFc + Group_f * PCc * PFc +
                             Memory_f * PCc * PFc + Timesec_trim,
                             data = df_complete, trace = FALSE)
h4 <- lr_test(fit_h4_no_int, fit_h4_full)
cat("H4 (Group × PC × Memory): χ² =", round(h4$chi_sq, 2), ", p =", format.pval(h4$p, digits = 3), "\n")

# H5: Group × Privacy Fatigue
# Note: Timesec_trim included as control variable (as reported in manuscript)
cat("\n=== H5: Group × Privacy Fatigue ===\n")
fit_h5_full <- multinom(Choice_f ~ Group_f * PFc + Memory_f + PCc + Timesec_trim, 
                         data = df_complete, trace = FALSE)
fit_h5_no_int <- multinom(Choice_f ~ Group_f + PFc + Memory_f + PCc + Timesec_trim, 
                           data = df_complete, trace = FALSE)
h5 <- lr_test(fit_h5_no_int, fit_h5_full)
cat("H5 (Group × PF): χ² =", round(h5$chi_sq, 2), ", p =", format.pval(h5$p, digits = 3), "\n")

# H6: Group × PF × Memory (three-way interaction)
# Note: Timesec_trim included as control variable (as reported in manuscript)
# Model includes all lower-order interactions up to the three-way term
cat("\n=== H6: Group × PF × Memory ===\n")
fit_h6_full <- multinom(Choice_f ~ Group_f * PFc * Memory_f + Group_f * PCc + 
                          Memory_f * PCc + PCc * PFc +
                          Group_f * Memory_f * PCc + Group_f * PCc * PFc +
                          Memory_f * PCc * PFc + Group_f * Memory_f * PCc * PFc + Timesec_trim,
                          data = df_complete, trace = FALSE)
fit_h6_no_int <- multinom(Choice_f ~ Group_f * PFc + Group_f * Memory_f + Group_f * PCc + 
                             Memory_f * PCc + Memory_f * PFc + PCc * PFc +
                             Group_f * Memory_f * PCc + Group_f * PCc * PFc +
                             Memory_f * PCc * PFc + Timesec_trim,
                             data = df_complete, trace = FALSE)
h6 <- lr_test(fit_h6_no_int, fit_h6_full)
cat("H6 (Group × PF × Memory): χ² =", round(h6$chi_sq, 2), ", p =", format.pval(h6$p, digits = 3), "\n")

# H7: PC × PF (Privacy Paradox)
# Note: Timesec_trim included as control variable (as reported in manuscript)
cat("\n=== H7: PC × PF (Privacy Paradox) ===\n")
fit_h7_full <- multinom(Choice_f ~ PCc * PFc + Group_f + Memory_f + Timesec_trim, 
                         data = df_complete, trace = FALSE)
fit_h7_no_int <- multinom(Choice_f ~ PCc + PFc + Group_f + Memory_f + Timesec_trim, 
                           data = df_complete, trace = FALSE)
h7 <- lr_test(fit_h7_no_int, fit_h7_full)
cat("H7 (PC × PF): χ² =", round(h7$chi_sq, 2), ", p =", format.pval(h7$p, digits = 3), "\n")

cat("\n=== Analysis Complete ===\n")
