# ============================================================
# 05 — CORRELATION AND REGRESSION
# ============================================================

library(stargazer)

# ============================================================
# CORRELATION
# ============================================================

correlation <- cor.test(
  mergeddata$expenditure,
  mergeddata$violent_crimes_per_thousand
)

print(correlation)

# ============================================================
# LINEAR REGRESSION
# ============================================================

model <- lm(
  violent_crimes_per_thousand ~ expenditure,
  data = mergeddata
)

summary(model)

# ============================================================
# REGRESSION OUTPUT
# ============================================================

regression <- stargazer(
  model,
  type = "text"
)

print(regression)
