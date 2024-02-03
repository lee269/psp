# https://r-graph-gallery.com/web-choropleth-map-lego-style.html
# https://geoportal.statistics.gov.uk/datasets/25dcac5ba5d246138968da883bc412df_0/explore

library(here)
library(ggplot2)
library(sf)
library(dplyr)
library(tidyr)
library(rnaturalearth)

# Load the boundary data for local authority districts
lad <- st_read(here("data", "maps", "lad", "LAD_DEC_2021_GB_BUC.shp"))

grid <- st_make_grid(lad, n = c(40,80)) |> 
  st_sf() |> 
  mutate(id = row_number()) |> 
  select(geometry = 1, id)

cent <- grid |> 
  st_centroid()

cent_clean<-cent%>%
  st_intersection(lad)

cent_no_geom <- cent_clean |> 
  st_drop_geometry()

grid_clean<-grid |> 
  left_join(cent_no_geom)


ggplot()+
  geom_sf(
    grid_clean |> drop_na(LAD21CD), 
    mapping=aes(geometry=geometry), fill = "green", colour = "white"
  )+
  theme_void()

# world <- ne_countries(scale = "medium", returnclass = "sf")
world <- ne_countries(scale = "small", type = "countries") |> 
  filter(sovereignt != "Antarctica")

grid <- st_make_grid(world, n = c(80,40)) |> 
  st_sf() |> 
  mutate(id = row_number()) |> 
  select(geometry = 1, id)

cent <- grid |> 
  st_centroid()

sf_use_s2(FALSE)
cent_clean<-cent%>%
  st_intersection(world)

cent_no_geom <- cent_clean |> 
  st_drop_geometry()

grid_clean<-grid |> 
  left_join(cent_no_geom)

ggplot()+
  geom_sf(
    grid_clean |> drop_na(featurecla), 
    mapping=aes(geometry=geometry), fill = "green", colour = "white"
  )+
  theme_void()



cty <- st_read(here("data", "maps", "counties", "CTYUA_MAY_2023_UK_BUC.shp"))

grid <- st_make_grid(cty, n = c(40,80)) |> 
  st_sf() |> 
  mutate(id = row_number()) |> 
  select(geometry = 1, id)

cent <- grid |> 
  st_centroid()

cent_clean<-cent%>%
  st_intersection(cty)

cent_no_geom <- cent_clean |> 
  st_drop_geometry()

grid_clean<-grid |> 
  left_join(cent_no_geom)


ggplot()+
  geom_sf(
    grid_clean |> drop_na(CTYUA23CD), 
    mapping=aes(geometry=geometry), fill = "green", colour = "white"
  )+
  theme_void()
