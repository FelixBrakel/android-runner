install.packages("ggplot2")
install.packages("dplyr")
install.packages("gridExtra")
library(ggplot2)
library(dplyr)
library(gridExtra)

# Loading data
energy_data <- read.csv("results-main.csv") %>%
  mutate(camera = ifelse(camera, "on", "off")) %>%
  mutate(microphone = ifelse(microphone, "on", "off")) %>%
  mutate(background = ifelse(background, "on", "off"))
energy_data_camera_on <- filter(energy_data, camera == "on")
meet_data <- energy_data %>% filter(app == "Meet")
zoom_data <- energy_data %>% filter(app == "Zoom")


test <- function(data1, data2) {
  wilcox.test(data1$joules, data2$joules)  
}

test(meet_data, zoom_data)

test(filter(meet_data, number_of_participants == "2"), filter(meet_data, number_of_participants == "5"))
test(filter(meet_data, camera == "off"), filter(meet_data, camera == "on"))
test(filter(meet_data, background == "off" & camera == "on"), filter(meet_data, background == "on" & camera == "on"))
test(filter(meet_data, microphone == "off"), filter(meet_data, microphone == "on"))

test(filter(zoom_data, number_of_participants == "2"), filter(zoom_data, number_of_participants == "5"))
test(filter(zoom_data, camera == "off"), filter(zoom_data, camera == "on"))
test(filter(zoom_data, background == "off" & camera == "on"), filter(zoom_data, background == "on" & camera == "on"))
test(filter(zoom_data, microphone == "off"), filter(zoom_data, microphone == "on"))
