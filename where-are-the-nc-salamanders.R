## Figure out where in NC/Southern Appalachia has the highest salamander diversity

library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)
library(dplyr)
library(ggplot2)
library(raster)

# Import shapefile of all salamander ranges
salamanders <- st_read("~/Documents/NorthCarolina/herping/salamandrous-spots-in-nc/CAUDATA/CAUDATA.shp")

# Basemaps
se.states <- ne_states(country = "united states of america", returnclass = "sf")%>%
  filter(name == "North Carolina" | name == "Georgia" | name == "Tennessee" | name == "South Carolina")
se.counties <- USAboundaries::us_counties(states = c("North Carolina", "Tennessee", "Georgia", "South Carolina"))

# Find the intersection of salamander polygons and SE polygon
sf_use_s2(FALSE)
sals.of.se <- st_intersection(salamanders, se.states)

# Crate a new raster to add the salamanders to. nrow and ncol make each cell ~1 mi x 1 mi across a rectangle covering SE
blank.se.raster <- raster(nrow = 814, ncol= 420, xmn = -91, xmx = -75, ymx = 36.7, ymn= 30)

# Make a raster from the salamanders of NC data
se.sal.raster <- rasterize(x = sals.of.se, y = blank.se.raster, field = "binomial", fun = "count")

# Basic plot
plot(se.sal.raster)

# Convert raster to dataframe for plotting in ggplot
se.sal.points <- rasterToPoints(se.sal.raster, spatial = TRUE)

# Then to a regular dataframe
se.sal.df <- data.frame(se.sal.points)

# Raster cell centroid with the greatest number of species. 29!!
filter(se.sal.df, layer == max(se.sal.df$layer))

# Plot the final map!
ggplot()+
  geom_raster(data = se.sal.df, aes(x = x, y = y, fill = layer))+
  geom_sf(data = se.counties, fill = NA, color = "gray50")+
  geom_sf(data = se.states, fill = NA)+
  scale_fill_gradientn(colors = terrain.colors(29), name = "Salamander\nSpecies", labels = c(5, 10,15, 20,25, 29), breaks = c(5, 10,15,20,25, 29))+
  geom_point(data = filter(se.sal.df, layer == 29), aes(x = x, y = y), color = "blue")+
  xlab(NULL)+
  ylab(NULL)+
  coord_sf(xlim = c(-85.2, -75.8), ylim = c(33.95,36.7))+
  theme_bw()

  
