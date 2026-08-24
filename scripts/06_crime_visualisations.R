# ============================================================
# 06 — CRIME VISUALISATIONS
# ============================================================

library(dplyr)
library(ggplot2)
library(stargazer)

# ============================================================
# PREPARE FINAL DATA
# ============================================================

df <- read.csv(
  "../data/final.csv"
)

df <- df |>
  select(-X)

df <- df |>
  rename(
    violent_crimes = total_violent_crimes
  )

# ============================================================
# CORRELATION: RAW VIOLENT CRIME
# ============================================================

correlation <- cor.test(
  df$expenditure,
  df$violent_crimes
)

print(correlation)

# ============================================================
# REGRESSION: RAW VIOLENT CRIME
# ============================================================

model <- lm(
  violent_crimes ~ expenditure,
  data = df,
  na.rm = TRUE
)

regression <- stargazer(
  model,
  type = "text"
)

print(regression)

# ============================================================
# YEAR-WISE SCATTERPLOT
# ============================================================

df |>
  ggplot(
    aes(
      x = expenditure,
      y = violent_crimes
    )
  ) +
  geom_point(alpha = 0.6) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "red"
  ) +
  facet_wrap(~ year) +
  labs(
    title = "Yearly Trends: Violent Crimes vs Education Expenditure",
    x = "Education Expenditure (% of GSDP)",
    y = "Violent Crimes"
  ) +
  theme_minimal()

# ============================================================
# ALL-YEAR SCATTERPLOT
# ============================================================

df |>
  ggplot(
    aes(
      x = expenditure,
      y = violent_crimes
    )
  ) +
  geom_point(alpha = 0.6) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "red"
  ) +
  labs(
    title = "Total Regression Trend: Violent Crimes vs Education Expenditure",
    x = "Education Expenditure (% of GSDP)",
    y = "Violent Crimes"
  ) +
  theme_minimal()

# ============================================================
# STATE-WISE SCATTERPLOT
# ============================================================

df |>
  ggplot(
    aes(
      x = expenditure,
      y = violent_crimes
    )
  ) +
  geom_point(alpha = 0.6) +
  geom_smooth(
    method = "lm",
    se = FALSE,
    color = "red"
  ) +
  facet_wrap(~ state) +
  labs(
    title = "State-wise Trends: Violent Crimes vs Education Expenditure",
    x = "Education Expenditure (% of GSDP)",
    y = "Violent Crimes"
  ) +
  theme_minimal()

# ============================================================
# STATE-WISE VIOLENT CRIME BAR CHARTS
# ============================================================

years <- unique(df$year)

lapply(
  years,
  function(yr) {
    
    p <- df |>
      filter(
        year == yr,
        !is.na(violent_crimes)
      ) |>
      ggplot(
        aes(
          x = reorder(
            state,
            violent_crimes
          ),
          y = violent_crimes
        )
      ) +
      geom_col(
        fill = "darkred"
      ) +
      coord_flip() +
      labs(
        title = paste(
          "Violent Crimes by State (",
          yr,
          ")",
          sep = ""
        ),
        x = "State",
        y = "Violent Crimes"
      ) +
      theme_minimal()
    
    print(p)
  }
)
