library(dplyr)

source("downloadFiles.R")

data <- mergedData %>%
  tbl_df() %>%
  group_by(year) %>%
  filter(
    (Data.Category %in% c("Nonroad", "Onroad") | type %in% c("ON-ROAD", "NON-ROAD"))
    & fips == "24510") %>%
  select(year, Emissions) %>%
  summarise(
    Emissions = sum(Emissions)
  )

png("plot5.png", width=800, height = 800)

barplot(
  Emissions ~ year,
  data = data,
  xlab = "Year",
  ylab = "Emissions (tons)",
  main = "Emissions from motor vehicle sources in Baltimore City",
  col = brewer.pal(length(data$year), "Set3"),
)

dev.off()