library(dplyr)
library(ggplot2)
library(waffle)

prod <- tibble(type = c("domestic"), vol = c(400))

prod |> 
  ggplot() + 
  geom_waffle(aes(fill = type, values = vol), n_rows = 20, colour = "white", size = 1) + 
  theme_void() +
  theme(legend.position = "none") +
  labs(title = "UK domestic production")

avail <- tibble(type = c("domestic", "exports"), vol = c(78*4, 22*4))

avail |> 
  ggplot() + 
  geom_waffle(aes(fill = type, values = vol),n_rows = 20, colour = "white", size = 1) + 
  theme_void() +
  theme(legend.position = "none") +
  labs(title = "UK domestic production")


supply <- tibble(type = c("domestic", "imports", "exports"), vol = c(58*4, 42*4, 9*4))

supply |> 
  ggplot() + 
  geom_waffle(aes(fill = type, values = vol),n_rows = 20, colour = "white", size = 1) + 
  scale_fill_manual(
    values = c("#f8766d", alpha("#00ba38", 1/3), "#619cff")
  ) +
  theme_void() +
  theme(legend.position = "none") +
  labs(title = "UK supply")

