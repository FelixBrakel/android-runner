library(tidyverse)
library(car)
library(ggplot2)
library(gridExtra)

data <- read.csv('results-main.csv')
data

data$app = as.factor(data$app)
data$number_of_participants = as.factor(data$number_of_participants)
data$camera = as.factor(data$camera)
data$microphone = as.factor(data$microphone)
data$background = as.factor(data$background)

check_normality <- function(dataset_to_eval, plot_title="") {
  plot(density(dataset_to_eval$joules), main=plot_title)
  qqPlot(dataset_to_eval$joules)
  print(shapiro.test(dataset_to_eval$joules)) # need to print explicitly in a loop
}

par(mfrow=c(1,2))

check_normality(data, "all data")

plot1 <- ggplot(data, aes(x=number_of_participants, y=joules, fill=app)) + geom_violin(trim=FALSE)
plot2 <- ggplot(data, aes(x=camera, y=joules, fill=app)) + geom_violin(trim=FALSE)
plot3 <- ggplot(data, aes(x=microphone, y=joules, fill=app)) + geom_violin(trim=FALSE)
plot4 <- ggplot(data, aes(x=background, y=joules, fill=app)) + geom_violin(trim=FALSE)


grid.arrange(plot1, plot2, plot3, plot4, nrow=2, ncol=2)

datazoomcam <- data %>%
  filter(app == "Zoom") %>%
  filter(camera == "True")

datazoomcamoff <- data %>%
  filter(app == "Zoom") %>%
  filter(camera == "False")

datameetcam <- data %>%
  filter(app == "Meet") %>%
  filter(camera == "True")

datameetcamoff <- data %>%
  filter(app == "Meet") %>%
  filter(camera == "False")

datazoommic <- data %>%
  filter(app == "Zoom") %>%
  filter(microphone == "True")

datazoommicoff <- data %>%
  filter(app == "Zoom") %>%
  filter(microphone == "False")

datameetmic <- data %>%
  filter(app == "Meet") %>%
  filter(microphone == "True")

datameetmicoff <- data %>%
  filter(app == "Meet") %>%
  filter(microphone == "False")

datazoom2 <- data %>%
  filter(app == "Zoom") %>%
  filter(number_of_participants == "2")

datazoom5 <- data %>%
  filter(app == "Zoom") %>%
  filter(number_of_participants == "5")

datameet2 <- data %>%
  filter(app == "Meet") %>%
  filter(number_of_participants == "2")

datameet5 <- data %>%
  filter(app == "Meet") %>%
  filter(number_of_participants == "5")

datazoomback <- data %>%
  filter(app == "Zoom") %>%
  filter(background == "True")

datazoomnoback <- data %>%
  filter(app == "Zoom") %>%
  filter(background == "False")

datameetback <- data %>%
  filter(app == "Meet") %>%
  filter(background == "True")

datameetnoback <- data %>%
  filter(app == "Meet") %>%
  filter(background == "False")

check_normality(datazoomcam, "zoom cam")
check_normality(datazoomcamoff, "zoom no cam")
check_normality(datameetcam, "meet cam")
check_normality(datameetcamoff, "meet no cam")

check_normality(datazoommic, "zoom mic")
check_normality(datazoommicoff, "zoom no mic")
check_normality(datameetmic, "meet mic")
check_normality(datameetmicoff, "meet no mic")

check_normality(datazoom2, "zoom 2")
check_normality(datazoom5, "zoom 5")
check_normality(datameet2, "meet 2")
check_normality(datameet5, "meet 5")

check_normality(datazoomback, "zoom back")
check_normality(datazoomnoback, "zoom no back")
check_normality(datameetback, "meet back")
check_normality(datameetnoback, "meet no back")

#---------------------------------------
datacam <- data %>%
  filter(camera == "True")

datacamoff <- data %>%
  filter(camera == "False")

datamic <- data %>%
  filter(microphone == "True")

datamicoff <- data %>%
  filter(microphone == "False")

data2 <- data %>%
  filter(number_of_participants == "2")

data5 <- data %>%
  filter(number_of_participants == "5")

databack <- data %>%
  filter(background == "True")

datanoback <- data %>%
  filter(background == "False")

check_normality(datacam, "cam")
check_normality(datacamoff, "no cam")

check_normality(datamic, "mic")
check_normality(datamicoff, "no mic")

check_normality(data2, "2")
check_normality(data5, "5")

check_normality(databack, "back")
check_normality(datanoback, "no back")