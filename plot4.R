# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?


#load library
library(dplyr)
library(ggplot2)
library(gridExtra)

### read zip file
NEI <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "summarySCC_PM25.rds"))

SCC <- readRDS(unzip("exdata_data_NEI_data.zip",
                     "Source_Classification_Code.rds"))


# merge two datasets
merged_data = NEI %>%
    left_join(SCC, by= "SCC")

# filter coal
NEI_coal = merged_data %>%
    filter(grepl("coal|Coal", 
                 EI.Sector))

# calculate the mean emissions for each year
NEI_total_coal = NEI_coal %>%
    group_by(year) %>%
    summarize(total = sum(Emissions, na.rm = TRUE))

# save the plots as png file
png(file="plot4.png", width=480, height=400)

plot(x = NEI_total_coal$year,
     y = NEI_total_coal$total,
     col = "blue",
     main = "The total emissions for each year from coal",
     xlab = "Year",
     ylab = "Total of emissions from PM2.5")
dev.off()
