library(rnaturalearth)
library(sf)

# Load the boundary data for local authority districts
lad <- st_read(here("data", "maps", "lad", "LAD_DEC_2021_GB_BUC.shp"))


boxes <- st_make_grid(lad , cellsize = 1.5e4,what = "polygons", square = TRUE) |> st_as_sf()


grid_lad <- boxes[c(unlist(st_contains(lad, boxes)), 
                    unlist(st_overlaps(lad, boxes))) ,] 


st_write(obj = grid_lad, here("data", "maps", "tilegrams", "uk_tilegram.shp"))



# world <- ne_countries(scale = "medium", returnclass = "sf")
world <- ne_countries(scale = "small", type = "countries") |> 
  filter(sovereignt != "Antarctica")


# x <- map_data("world")

# map <- world |> filter(type == "Sovereign country")
wboxes <- st_make_grid(world , cellsize = 3,what = "polygons", square = TRUE,crs = "WGS84") |> st_as_sf()
sf_use_s2(FALSE)
grid_w <- wboxes[c(unlist(st_contains(world, wboxes)), 
                   unlist(st_overlaps(world, wboxes))) ,] 

st_write(obj = grid_w, here("data", "maps", "tilegrams", "world_tilegram.shp"))
