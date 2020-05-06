library(dplyr)
library(RColorBrewer)

source("downloadFiles.R")

data <- pm25 %>%
        tbl_df() %>%
        group_by(year) %>%
        select(year, Emissions) %>%
        summarise(
          Emissions = sum(Emissions)
        )

png("plot1.png", width=800, height = 800)

barplot(
  Emissions / 1000 ~ year,
  data = data,
  xlab = "Year",
  ylab = "Total Emissions (thousands of tons)",
  col = brewer.pal(length(data$year), "Set3"),
)

dev.off()