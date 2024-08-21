# Set working directory
main_dir <- dirname(rstudioapi::getSourceEditorContext()$path)
setwd(main_dir)

# Install or call libraries
if (!require("pacman")) install.packages("pacman")

pacman::p_load(tidyverse, raster, sf, rnaturalearth, ggrepel, ggspatial)

# Read Natural Earth 2 map as raster object

natearth_map <- 
  raster::stack('NE2_HR_LC_SR_W_DR/NE2_HR_LC_SR_W_DR.tif') %>% # import tiff as rasterStack
  crop(extent(1, 45, 38, 58)) %>%                                   # subset to desired extent
  as.array %>%                                                      # convert to 3D array
  `/`(255) %>%                                                      # switch to proportions to meet rgb() requirements
  apply(c(1, 2), function(x) rgb(matrix(x, ncol = 3))) %>%          # collapse layers to RGB colors
  annotation_raster(1, 45, 38, 58)

# Create a map of world countries
world_countries <- ne_countries(scale = "small", returnclass = "sf")

# Set coordinates of the Lower Austria region
area <- data.frame(city = c("Lower Austria"),
                   lat = c(47.9984),
                   lng = c(16.8546))

area <- st_as_sf(area, coords = c("lng", "lat"), remove = FALSE,
                 crs = 4326, agr = "constant")

# Set coordinates of European cities
cities <- data.frame(city = c("Rostov-on-Don", "Rossla", "Magdeburg", "Hanover", "Lubenia", "Rybnik", "Brno"),
                     lat = c(47.2357, 51.4631, 52.1132, 52.3759, 49.9252, 50.1022, 49.1951),
                     lng = c(39.7015,11.0697, 11.6081, 9.7320, 21.9312, 18.5463, 16.6068))

cities <- st_as_sf(cities, coords = c("lng", "lat"), remove = FALSE,
                   crs = 4326, agr = "constant")

# Set coordinates of Rostov-on-Don
rostov_city <- data.frame(city = c("Rostov-on-Don"),
                     lat = c(47.2357),
                     lng = c(39.7015))

rostov_city <- st_as_sf(rostov_city, coords = c("lng", "lat"), remove = FALSE,
                   crs = 4326, agr = "constant")

# Plot a map
ggplot(data = world_countries) +
  geom_sf()+
  natearth_map +
  annotate("text", x = 40, y = 54, label = "Russia", color = "black", alpha = 0.33, size = 4, fontface = "bold") +
  geom_text_repel(data = cities,
                  aes(x = lng, y = lat, label = city),
                  size = 4,
                  fontface = "bold",
                  nudge_x = c(0, 0.15,-0.15, 0.3, 0.45, 0.6),
                  nudge_y = c(0.75, -0.75, 1, -1, 1.25, -1.25)) +
  geom_text_repel(data = rostov_city,
                  aes(x = lng, y = lat, label = city),
                  size = 4,
                  fontface = "bold",
                  nudge_x = c(0),
                  nudge_y = c(0.75)) +
  geom_text_repel(data = area,
                  aes(x = lng, y = lat, label = city),
                  size = 4,
                  fontface = "bold",
                  nudge_x = c(0, 0.15,-0.15, 0.3, 0.45, 0.6),
                  nudge_y = c(-0.75, -1, -1.25)) +
  geom_text_repel(data = world_countries %>% filter(!(admin %in% c("Kosovo"))),
                  stat = "sf_coordinates",
                  aes(label = name, geometry = geometry),
                  color = "black",
                  alpha = 0.33,
                  size = 4,
                  fontface = "bold") +
  geom_point(data = cities,
             aes(x = lng, y = lat),
             size = 4, 
             shape = 23,
             fill = "darkred") +
  geom_point(data = area,
             aes(x = lng, y = lat),
             size = 4, 
             shape = 21,
             fill = "darkred") +
  geom_point(data = rostov_city,
             aes(x = lng, y = lat),
             size = 4, 
             shape = 23,
             fill = "darkblue") +
  coord_sf(xlim = c(1, 45), ylim = c(38, 58), expand = FALSE)+
  annotation_scale(location = "bl", width_hint = 0.4) +
  annotation_north_arrow(location = "bl", which_north = "true", 
                         pad_x = unit(0.75, "in"), pad_y = unit(0.5, "in"),
                         style = north_arrow_fancy_orienteering) +
  xlab("Longitude") +
  ylab("Latitude")

# Save it in 600 dpi
ggsave("geo-map.png", width = 10, height = 6, dpi=600)

# Special thanks to these guides:
# 1. https://stackoverflow.com/questions/69852503
# 2. https://r-spatial.org/r/2018/10/25/ggplot2-sf-2.html
# 3. https://tsamsonov.github.io/r-geo-course/