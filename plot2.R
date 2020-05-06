library(dplyr)

source("downloadFiles.R")

data <- pm25 %>%
  tbl_df() %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  select(year, Emissions) %>%
  summarise(
    Emissions = sum(Emissions)
  )

png("plot2.png", width=800, height = 800)

barplot(
  Emissions ~ year,
  data = data,
  xlab = "Year",
  ylab = "Total Emissions (tons)",
  main = "Emissions in Baltimore City",
  col = brewer.pal(length(data$year), "Set3"),
)

dev.off()