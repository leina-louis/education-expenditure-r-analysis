# ============================================================
# DDD PROJECT: EDUCATION EXPENDITURE AND VIOLENT CRIME
# 01 — EDUCATION DATA: CENSUS 2011
# ============================================================

library(dplyr)
library(ggplot2)
library(tidyverse)
library(readr)

# ============================================================
# LOAD CENSUS DATA
# ============================================================

df <- read.csv(
  "../data/india-districts-census-2011_rev.csv"
)

head(df)

# ============================================================
# EDUCATION DATA
# ============================================================

edu <- df |>
  select(2, 4, 42, 43, 44, 45, 46, 50)

edu$Secondary_Education <-
  edu$Middle_Education + edu$Secondary_Education

edu$Higher_Education <-
  edu$Higher_Education + edu$Graduate_Education

ed <- edu |>
  select(1, 2, 3, 5, 6, 8)

education <- ed |>
  group_by(State.name) |>
  summarise(
    population = sum(Population),
    primary = sum(Primary_Education),
    secondary = sum(Secondary_Education),
    higher = sum(Higher_Education),
    total = sum(Total_Education)
  )

education <- education |>
  rename(state = State.name)

education <- education[
  c(2, 4, 5, 11, 12, 13, 14, 15, 16, 17, 19, 20,
    26, 28, 29, 31, 33, 35),
]

education <- education |>
  mutate(
    total = primary + secondary + higher,
    p_percentage = (primary / population) * 100,
    s_percentage = (secondary / population) * 100,
    h_percentage = (higher / population) * 100,
    tot_percentage = (total / population) * 100
  )

# ============================================================
# TOTAL EDUCATED POPULATION BY STATE
# ============================================================

ggplot(
  education,
  aes(
    x = state,
    y = tot_percentage
  )
) +
  geom_col(fill = "lightpink") +
  labs(
    title = "Total Education by State",
    x = "State",
    y = "Education Percentage (%)"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )

# ============================================================
# EDUCATION COMPOSITION BY LEVEL
# ============================================================

education_long <- education |>
  select(
    state,
    p_percentage,
    s_percentage,
    h_percentage
  ) |>
  pivot_longer(
    cols = c(
      p_percentage,
      s_percentage,
      h_percentage
    ),
    names_to = "education_level",
    values_to = "percentage"
  ) |>
  mutate(
    education_level = case_when(
      education_level == "p_percentage" ~ "Primary",
      education_level == "s_percentage" ~ "Secondary",
      education_level == "h_percentage" ~ "Higher"
    )
  )

education_long$education_level <- factor(
  education_long$education_level,
  levels = c(
    "Higher",
    "Secondary",
    "Primary"
  )
)

ggplot(
  education_long,
  aes(
    x = state,
    y = percentage,
    fill = education_level
  )
) +
  geom_col() +
  scale_fill_manual(
    values = c(
      "Primary" = "violet",
      "Secondary" = "orchid",
      "Higher" = "darkorchid"
    )
  ) +
  labs(
    title = "Education Composition by State (Relative to Population)",
    x = "State",
    y = "Percentage (%)",
    fill = "Education Level"
  ) +
  theme_minimal() +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )