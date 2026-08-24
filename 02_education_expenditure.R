# ============================================================
# 02 — EDUCATION EXPENDITURE
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyverse)
library(readxl)

# ============================================================
# LOAD EDUCATION EXPENDITURE DATA
# ============================================================

df <- read_excel(
  "../data/pct_gsdp.xlsx"
)

df_long <- df |>
  pivot_longer(
    cols = -Year,
    names_to = "State",
    values_to = "Expenditure"
  )

df_wide <- df_long |>
  pivot_wider(
    names_from = Year,
    values_from = Expenditure
  )

df <- df_wide

df <- df |>
  select(c(-(2:11)))

df_long <- df_long[-(1:180), ]

df_long$Year <- as.factor(df_long$Year)

# ============================================================
# STATE-WISE TREND
# ============================================================

ggplot(
  df_long,
  aes(
    x = Year,
    y = Expenditure,
    color = State,
    group = State
  )
) +
  geom_line() +
  labs(
    title = "State-wise Education Expenditure (% of GSDP)",
    x = "Year",
    y = "Expenditure (% of GSDP)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )

# ============================================================
# STATE FACET PLOTS
# ============================================================

states <- unique(df_long$State)

df_long |>
  ggplot(
    aes(
      x = Year,
      y = Expenditure,
      group = 1
    )
  ) +
  geom_line(
    color = "black",
    size = 1
  ) +
  geom_point(
    color = "darkred",
    size = 2
  ) +
  labs(
    title = "Education Expenditure (% of GSDP) by State",
    x = "Year",
    y = "% of GSDP"
  ) +
  facet_wrap(~ State) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    ),
    strip.text = element_text(
      face = "bold"
    ),
    plot.title = element_text(
      face = "bold",
      size = 16
    )
  )