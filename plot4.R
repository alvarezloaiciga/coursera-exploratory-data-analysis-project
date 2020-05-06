library(dplyr)

source("downloadFiles.R")

data <- mergedData %>%
  tbl_df() %>%
  group_by(year) %>%
  filter(grepl("[C,c]oal", Short.Name)) %>%
  select(year, Emissions) %>%
  summarise(
    Emissions = sum(Emissions)
  )

png("plot4.png", width=800, height = 800)

barplot(
  Emissions / 1000 ~ year,
  data = data,
  xlab = "Year",
  ylab = "Total Emissions (thousands of tons)",
  main = "Emissions  from coal combustion related sources",
  col = brewer.pal(length(data$year), "Set3"),
)

dev.off()