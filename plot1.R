#### 01. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#load library
library(dplyr)

### read zip file
NEI <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "summarySCC_PM25.rds"))


# calculate the mean emissions for each year
NEI_total = NEI %>%
    group_by(year) %>%
    summarize(total = sum(Emissions, na.rm = TRUE))

# save the plots as png file
png(file="plot1.png", width=480, height=400)


plot(x = NEI_total$year,
     y = NEI_total$total,
     col = "blue",
     main = "The total emissions from PM2.5 for each year",
     xlab = "Year",
     ylab = "Total of emissions from PM2.5")
dev.off()
