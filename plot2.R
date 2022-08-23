#### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland fips == "24510" from 1999 to 2008? Use the base plotting system to make a plot answering this question

#load library
library(dplyr)

### read zip file
NEI <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "summarySCC_PM25.rds"))

# filter the Baltimore
NEI_baltimore = NEI %>%
    dplyr::filter(fips == "24510")



# calculate the mean emissions for each year
NEI_total_balt = NEI_baltimore %>%
    group_by(year) %>%
    summarize(total = sum(Emissions, na.rm = TRUE))

# save the plots as png file
png(file="plot2.png", width=480, height=400)



plot(x = NEI_total_balt$year,
     y = NEI_total_balt$total,
     col = "blue",
     main = "The total of total emissions from PM2.5 for each year in Baltomore",
     xlab = "Year",
     ylab = "Total of emissions from PM2.5")
dev.off()
