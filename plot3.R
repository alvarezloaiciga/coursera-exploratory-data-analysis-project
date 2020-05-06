library(dplyr)
library(RColorBrewer)
library(ggplot2)

source("downloadFiles.R")

data <- pm25 %>%
  tbl_df() %>%
  mutate(year = factor(year)) %>%
  group_by(type, year) %>%
  summarise(
    Emissions = sum(Emissions)
  )

png("plot3.png", width=800, height = 800)

years <- rep(brewer.pal(length(unique(data$year)), "Set3"), length(unique(data$type)))

graph <- qplot(
  year,
  Emissions / 1000,
  data = data,
  facets = .~type,
  xlab = "Year",
  ylab = "Emissions (thousands of tons)",
  geom = "col",
  show.legend = FALSE,
  fill = years)

print(graph)

dev.off()