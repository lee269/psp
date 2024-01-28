# https://r-graph-gallery.com/web-choropleth-map-lego-style.html
# https://geoportal.statistics.gov.uk/datasets/25dcac5ba5d246138968da883bc412df_0/explore

library(here)
library(ggplot2)
library(sf)
library(dplyr)
library(tidyr)

# Load the boundary data for local authority districts
lad <- st_read(here("data", "maps", "lad", "LAD_DEC_2021_GB_BUC.shp"))

ggplot(lad) +
  geom_sf(fill = "blue")

grid <- st_make_grid(lad, n = c(60,60)) |> 
  st_sf() |> 
  mutate(id = row_number()) |> 
  select(geometry = 1, id)

cent <- grid |> 
  st_centroid()

ggplot() +
  geom_sf(grid, mapping = aes(geometry = geometry)) +
  geom_sf(cent,mapping=aes(geometry=geometry),pch=21,size=0.5)



cent_clean<-cent%>%
  st_intersection(lad)

cent_no_geom <- cent_clean |> 
  st_drop_geometry()

grid_clean<-grid |> 
  #filter(id%in%sel)%>%
  left_join(cent_no_geom)


ggplot()+
  geom_sf(
    grid_clean |> drop_na(LAD21CD), 
    mapping=aes(geometry=geometry), fill = "green"
  )+
  geom_sf(cent_clean,mapping=aes(geometry=geometry),fill=NA,pch=21,size=0.5)

