# ============================================================
# 04 — CRIME AND CENSUS POPULATION
# ============================================================

library(dplyr)
library(readr)

# ============================================================
# LOAD DATA
# ============================================================

census <- read_csv(
  "../data/india-districts-census-2011_rev.csv"
)

final_csv <- read_csv(
  "../data/final.csv"
)

# ============================================================
# CENSUS POPULATION BY STATE
# ============================================================

census_population <- census %>%
  group_by(`State name`) %>%
  summarise(
    population = sum(
      Population,
      na.rm = TRUE
    )
  )

census_population <- census_population %>%
  rename(
    states_u_ts = `State name`
  )

census_population <- census_population |>
  mutate(
    states_u_ts = tolower(states_u_ts)
  )

# ============================================================
# CALCULATE VIOLENT CRIME PER THOUSAND
# ============================================================

final_csv$state <- toupper(
  trimws(final_csv$state)
)

census_population$states_u_ts <- toupper(
  trimws(census_population$states_u_ts)
)

mergeddata <- merge(
  final_csv,
  census_population,
  by.x = "state",
  by.y = "states_u_ts",
  all.x = TRUE
)

mergeddata$violent_crimes_per_thousand <- (
  mergeddata$total_violent_crimes /
    mergeddata$population
) * 1000

mergeddata <- mergeddata[
  complete.cases(
    mergeddata[
      ,
      c(
        "violent_crimes_per_thousand",
        "expenditure"
      )
    ]
  ),
]
