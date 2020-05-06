if(!dir.exists("data")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", temp)
  unzip(temp, exdir = paste0(getwd(), "/data"))
  unlink(temp)
  rm(tmp)
}

if (!("codes" %in% ls())) {
  codes <- readRDS("./data/Source_Classification_Code.rds")
}

if (!("pm25" %in% ls())) {
  pm25 <- readRDS("./data/summarySCC_PM25.rds")
}

if (!("mergedData" %in% ls())) {
  mergedData <- merge(pm25, codes, by.x = "SCC", by.y = "SCC")
}
