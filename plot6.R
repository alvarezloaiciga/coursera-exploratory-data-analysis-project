library(dplyr)

source("downloadFiles.R")


places <- list("24510" = "Balmitore City", "06037" = "Los Angeles County")

data <- mergedData %>%
  tbl_df() %>%
  filter(
    (Data.Category %in% c("Nonroad", "Onroad") | type %in% c("ON-ROAD", "NON-ROAD"))
    & fips %in% names(places)) %>%
  mutate(year = factor(year)) %>%
  group_by(fips, year) %>%
  select(year, fips, Emissions) %>%
  summarise(
    Emissions = sum(Emissions)
  )

data$fips <- recode(data$fips, !!!places)

png("plot6.png", width=800, height = 800)

years <- rep(brewer.pal(length(unique(data$year)), "Set3"), length(unique(data$fips)))

graph <- qplot(
  year,
  Emissions,
  data = data,
  facets = .~fips,
  xlab = "Year",
  ylab = "Emissions (tons)",
  geom = "col",
  show.legend = FALSE,
  main = "Emissions from motor vehicle sources",
  fill = years)

print(graph)

dev.off()