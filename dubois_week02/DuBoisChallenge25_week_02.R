#Library 
library(ggplot2)
library(readxl)
library(showtext)
library(dplyr)
library(scales)
library(grid)
library(jpeg)

#Jpeg Background
img <- jpeg::readJPEG("C:\\Users\\rvillarincon\\OneDrive - Wenatchee Valley College\\Documents\\Pictures\\outline.jpg")
grid.newpage()
grid.raster(img, width = unit(1, "npc"), height = unit(1, "npc"))

#Import Google Fonts
font_add_google("Quantico", "quantico")
font_add_google("Jura", "jura")
showtext_auto()

#Data
dataset <- data_3_

#Flip Data and Add Row Number
flipped_data <- dataset[nrow(dataset):1, ]
flipped_data <- flipped_data |>
  mutate(row_number = seq_along(Date))

#Data Is Treated As A Factor With Reverse Order
flipped_data$Date <- factor(flipped_data$Date, levels = flipped_data$Date)

#BarGraph
p <- ggplot(flipped_data, aes(x = Date, y = Land)) +
  geom_col(fill = "#e93a58", width = 0.6) +
  coord_flip()+
  labs(title = "                           ACRES  OF  LAND  OWNED  BY  NEGROS\n                                                    IN  GEORGIA.", x = "", y = "") +
  theme(
    panel.grid = element_blank(),
    panel.background = element_rect(fill = "transparent"),
    plot.background = element_rect(fill = "transparent"),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank(),
    axis.ticks.y = element_blank(),
    axis.text.y = element_text(margin = margin(r = -16),
    family = "jura",
    face = "plain",
    color = "grey48",
                               ),
    plot.title = element_text(
      size = 9,
      face = "bold",
      family = "quantico",
      color = "grey26",
      margin = margin(t = 15, b = 1)
    )
  ) +
  
#labels To Bars
  geom_text(
    aes(label = ifelse(row_number == 1, comma(Land), "")),
    hjust = 4.5,
    vjust = 0.5,
    color = "grey20",
    size = 2.5,
    family = "quantico",
    fontface = "bold",
  ) +
  geom_text(
    aes(label = ifelse(row_number == 25, comma(Land), "")),
    hjust = 2,
    vjust = 0.5,
    color = "grey20",
    size = 2.5,
    family = "quantico",
    fontface = "bold")

#Print The Plot
print(p, newpage = FALSE)
