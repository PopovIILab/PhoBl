#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly=TRUE)

library(ggplot2)
library(rnaturalearth)
library(dplyr)

europe_map <- ne_countries(continent = "europe", returnclass = "sf")

route_cities <- data.frame(
  lon = c(39.7015, 22.003, 18.7006, 10.0805, 9.2158, 9.732, 16.6068, 16.8546, 39.7015),
  lat = c(47.2357, 50.0412, 50.045, 52.6264, 52.643, 52.3759, 49.1951, 47.9984, 47.2357)
)

ggplot(data = europe_map) +
  geom_sf(fill = "white", color = NA) +
  geom_path(data = route_cities, aes(x = lon, y = lat), color = "#1bd194", size = 1, linetype = 1) +
  geom_point(data = route_cities, aes(x = lon, y = lat), color = "black", size = 4, shape = 21, fill = "#FF0000") +
  geom_sf_label(data = europe_map %>% filter(!(admin %in% c("Netherlands", "Belgium", "Luxembourg"))),
                aes(label = name), fill = "white", color = "grey", alpha = 0.1, size = 6, position = "identity", 
                fontface = "bold", label.size = NA) +
  annotate("text", x = 40, y = 54, label = "Russia", color = "grey", alpha = 1, size = 6, fontface = "bold") +
  annotate("text", x = 39.7015, y = 47.9357, label = "Rostov-on-Don", color = "grey", alpha = 0.9, size = 4) +
  annotate("text", x = 18.55, y = 49.1951 + 0.3, label = "Brno", color = "grey", alpha = 1, size = 4) +
  geom_segment(aes(x = 39.7015, y = 47.2357, xend = 39.7015, yend = 47.9357 - 0.3), color = "grey", linetype = "dashed") +
  geom_segment(aes(x = 16.6068, y = 49.1951, xend = 17.75, yend = 49.1951 + 0.3), color = "grey", linetype = "dashed") +
  coord_sf(xlim = c(5, 50), ylim = c(45, 60), expand = FALSE) +
  theme_minimal() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    panel.background = element_rect(fill = "#78d2ff", colour = NA),
    text = element_text(size = 12),
    axis.text.x = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )

ggsave(args[1], width = 10, height = 6, dpi=600)
