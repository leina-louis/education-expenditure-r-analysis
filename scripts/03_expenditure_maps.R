# ============================================================
# 03 — EDUCATION EXPENDITURE: INDIA MAPS
# ============================================================

library(dplyr)
library(ggplot2)
library(sf)
library(geojsonsf)

# ============================================================
# LOAD MAP
# ============================================================

india_sf <- geojson_sf(
  "../data/india.geojson"
)

names(india_sf)

# ============================================================
# PREPARE MAP DATA
# ============================================================

df_new <- df_long |>
  mutate(
    ISO = recode(
      State,
      "AP"  = "IN-AP",
      "AS"  = "IN-AS",
      "BH"  = "IN-BR",
      "GU"  = "IN-GJ",
      "HR"  = "IN-HR",
      "HP"  = "IN-HP",
      "J&K" = "IN-JK",
      "JHA" = "IN-JH",
      "KA"  = "IN-KA",
      "KE"  = "IN-KL",
      "MP"  = "IN-MP",
      "MH"  = "IN-MH",
      "OR"  = "IN-OR",
      "PN"  = "IN-PB",
      "RJ"  = "IN-RJ",
      "TN"  = "IN-TN",
      "UP"  = "IN-UP",
      "WB"  = "IN-WB"
    )
  )

years <- unique(df_new$Year)

max_val <- max(
  df_new$Expenditure,
  na.rm = TRUE
)

# ============================================================
# GENERATE MAPS
# ============================================================

lapply(
  years,
  function(y) {
    
    map_data <- india_sf |>
      left_join(
        df_new |>
          filter(Year == y),
        by = c("shapeISO" = "ISO")
      )
    
    ggplot(map_data) +
      geom_sf(
        aes(fill = Expenditure),
        color = "white",
        size = 0.2
      ) +
      scale_fill_viridis_c(
        option = "C",
        na.value = "grey",
        name = "% of GSDP",
        limits = c(0, max_val)
      ) +
      labs(
        title = paste(
          "Education Expenditure (% of GSDP) —",
          y
        )
      ) +
      theme_void() +
      theme(
        legend.position = "bottom",
        plot.title = element_text(
          hjust = 0.5,
          face = "bold"
        ),
        legend.title = element_text(
          size = 10
        ),
        legend.text = element_text(
          size = 8
        )
      ) -> p
    
    print(p)
  }
)

# ============================================================
# SAVE DATA
# ============================================================

write.csv(
  df_new,
  "../data/gsdp.csv"
)
