library(dplyr)
library(networkD3)
library(readr)
library(here)

nodes <- read_csv(here("data", "nodes2.csv"))
links <- read_csv(here("data", "links2.csv"))

my_color <- 'd3.scaleOrdinal() .domain(["UK", "Trade", "Total"]) .range(["#9ACD32", "#EEEEE0", "olivedrab"])'

sankeyNetwork(Links = links,
              Nodes = nodes, 
              Source = 'source',
              Target = 'target',
              Value = 'value',
              NodeID = 'name',
              NodeGroup = 'node_group',LinkGroup = 'link_type',
              colourScale = my_color,
              fontSize = 28,
              fontFamily = "Arial",
              units = "%",
              nodeWidth = 30,
              nodePadding = 20,
              sinksRight = FALSE)

