install.packages("ggplot2")
install.packages("dplyr")
library(ggplot2)
library(dplyr)

energy_data <- read.csv("results-main.csv") %>%
  mutate(camera = ifelse(camera, "on", "off")) %>%
  mutate(microphone = ifelse(microphone, "on", "off")) %>%
  mutate(background = ifelse(background, "on", "off"))

energy_data_camera_on <- filter(energy_data, camera == "on")

meet_data <- energy_data %>% filter(app == "Meet")
zoom_data <- energy_data %>% filter(app == "Zoom")

# Summaries
summary(meet_data$joules)
summary(zoom_data$joules)
summary(energy_data$joules)

# Meet summaries
summary(filter(meet_data, number_of_participants == 2)$joules)
summary(filter(meet_data, number_of_participants == 5)$joules)
summary(filter(meet_data, camera == "off")$joules)
summary(filter(meet_data, camera == "on")$joules)
summary(filter(meet_data, background == "off" & camera == "on")$joules)
summary(filter(meet_data, background == "on" & camera == "on")$joules)
summary(filter(meet_data, microphone == "off")$joules)
summary(filter(meet_data, microphone == "on")$joules)
summary(meet_data$joules)


# Zoom summaries
summary(filter(zoom_data, number_of_participants == 2)$joules)
summary(filter(zoom_data, number_of_participants == 5)$joules)
summary(filter(zoom_data, camera == "off")$joules)
summary(filter(zoom_data, camera == "on")$joules)
summary(filter(zoom_data, background == "off" & camera == "on")$joules)
summary(filter(zoom_data, background == "on" & camera == "on")$joules)
summary(filter(zoom_data, microphone == "off")$joules)
summary(filter(zoom_data, microphone == "on")$joules)
summary(zoom_data$joules)


# Boxplot for the different apps
ggplot(data = energy_data, aes(x = as.factor(app), y = joules)) +
  ylim(0, NA) +
  xlab("App") +
  ylab("Energy consumption [J]") +
  geom_violin() + 
  geom_boxplot(width=.1, alpha=.5, position=position_dodge(.9)) +
  stat_summary(fun=mean, geom="point", shape="diamond", size=3, color="black")

# Scatterplot for the different apps, color-/shape-coded with camera and mic
ggplot(data = energy_data, aes(x = as.factor(app), y = joules, color = camera, shape = microphone)) +
  ylim(0, NA) +
  xlab("App") +
  ylab("Energy consumption [J]") +
  geom_jitter()


# General histogram of energy consumption
ggplot() +
  geom_histogram(data = energy_data, aes(x = joules), binwidth = 40) +
  xlim(0, NA) +
  xlab("Energy consumption [J]") + 
  ylab("Count")

# Meet histogram
ggplot() +
  geom_histogram(data = meet_data, aes(x = joules), binwidth = 20) +
  xlim(0, NA) +
  xlab("Energy consumption [J]") + 
  ylab("Count")

# Zoom histogram
ggplot() +
  geom_histogram(data = zoom_data, aes(x = joules), binwidth = 20) +
  xlim(0, NA) +
  xlab("Energy consumption [J]") + 
  ylab("Count")

# Violin plot: Camera (for the different apps)
ggplot(data = energy_data, aes(x = as.factor(app), y = joules, fill = camera)) +
  ylim(0, NA) +
  xlab("App") +
  ylab("Energy consumption [J]") +
  labs(fill = "Camera") +
  geom_violin() + 
  geom_boxplot(width=.15, alpha=.5, position=position_dodge(.9)) +
  stat_summary(fun=mean, geom="point", shape="diamond", size=3, color="black", position=position_dodge(.9))

# Violin plot: Background (for the different apps)
ggplot(data = energy_data_camera_on, aes(x = as.factor(app), y = joules, fill = background)) +
  ylim(0, NA) +
  xlab("App") +
  ylab("Energy consumption [J]") +
  labs(fill = "Virtual\nbackground") +
  geom_violin() + 
  geom_boxplot(width=.15, alpha=.5, position=position_dodge(.9)) +
  stat_summary(fun=mean, geom="point", shape="diamond", size=3, color="black", position=position_dodge(.9))


# Violin plot: Microphone (for the different apps)
ggplot(data = energy_data, aes(x = as.factor(app), y = joules, fill = microphone)) +
  ylim(0, NA) +
  xlab("App") +
  ylab("Energy consumption [J]") +
  labs(fill = "Microphone") +
  geom_violin() + 
  geom_boxplot(width=.15, alpha=.5, position=position_dodge(.9)) +
  stat_summary(fun=mean, geom="point", shape="diamond", size=3, color="black", position=position_dodge(.9))


# Violin plot: Number of participants (for the different apps)
ggplot(data = energy_data, aes(x = as.factor(app), y = joules, fill = as.factor(number_of_participants))) +
  ylim(0, NA) +
  xlab("App") +
  ylab("Energy consumption [J]") +
  labs(fill = "Num. of\nparticip.") +
  geom_violin() +
  geom_boxplot(width=.15, alpha=.5, position=position_dodge(.9)) +
  stat_summary(fun=mean, geom="point", shape="diamond", size=3, color="black", position=position_dodge(.9))


#mean(filter(energy_data, camera=="on")$joules)/mean(filter(energy_data, camera=="off")$joules)

meet_camoff <- filter(meet_data, camera == "off")
ggplot(data = meet_camoff, aes(x = as.factor(number_of_participants), y = joules)) +
  ylim(0, NA) +
  xlab("Number of participants") +
  ylab("Energy consumption [J]") +
  labs(fill = "App") +
  geom_boxplot()

